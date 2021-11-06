Rails.application.routes.draw do

  devise_for :customer,skip: [:passwords,], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root "customer/homes#top"

  scope module: :customer do
    get "/about", to: "homes#about"

    get "/customers/:id/withdraw_confirm", to: "customer#withdraw_confirm"
    get "/customers/:id/mypage", to: "customer#mypage"
    patch "/customer/:id/withdraw", to: "customer#withdraw"
    resources :customers, only:[:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      resource :assessments, only: [:create, :destroy]
      get 'likes' => 'relationships#likes', as: 'likes'
      get 'get_likes' => 'relationships#get_likes', as: 'get_likes'
    end

    resources :dogs
    resources :requests, expect: [:index]
    resources :applications, only: [:create, :destroy, :edit, :update]
    resources :contracts, only: [:create, :new, :show, :update]
    get "/contracts/complete", to: "customer#complete"
    get "/contracts/check", to: "customer#check"

    #chat未
  end

  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update]
    resources :contracts, only: [:index, :show]
  end



end
