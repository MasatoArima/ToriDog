Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :customer, skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions',
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions",
  }

  root "customer/homes#top"

  scope module: :customer do
    get "/about", to: "homes#about"

    get "/customers/withdraw_confirm", to: "customers#withdraw_confirm"
    get "/customers/mypage", to: "customers#mypage"
    patch "/customers/withdraw", to: "customers#withdraw"
    resources :customers, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      resource :assessments, only: [:create, :destroy]
      get 'likings' => 'assessments#likings', as: 'likings'
      get 'likers' => 'assessments#likers', as: 'likers'
    end

    resources :contacts, only: [:index, :create]

    resources :dogs
    resources :requests, expect: [:index]
    resources :applications, only: [:create, :destroy, :edit, :update]
    get "/contracts/complete", to: "contracts#complete"
    get "/contracts/check", to: "contracts#check"
    resources :contracts, only: [:create, :new, :show, :update, :destroy]

    resources :chats, only: [:show, :create, :destroy]
    resources :news, only: [:index]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :contracts, only: [:index, :show]
  end
end
