Rails.application.routes.draw do

devise_for :customers,skip: [:passwords,], controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

end
