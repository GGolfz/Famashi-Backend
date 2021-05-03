Rails.application.routes.draw do
  
  namespace :api do
    match 'auth/register', to: 'auth#register', via: [:post]
    match 'auth/login', to: 'auth#login', via: [:post]
    match 'user/password', to: 'user#password', via: [:post]
    match 'user/image', to: 'user#image', via: [:post]
    resources :user, only: [:index,:update]
    resources :medical, only: [:index,:update]
    resources :reminders, only: [:index,:update]
    resources :allergies, only: [:index,:create,:update,:destroy]
    resources :medicines, only: [:index,:create,:update,:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
