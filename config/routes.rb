Rails.application.routes.draw do
  
  namespace :api, defaults: {format: :json} do
    match 'auth/register', to: 'auth#register', via: [:post]
    match 'auth/login', to: 'auth#login', via: [:post]
    match 'user/password', to: 'user#password', via: [:patch]
    match 'user/notification', to: 'user#notification_get', via:[:get]
    match 'user/notification', to: 'user#notification_patch', via:[:patch]
    match 'user', to: 'user#update', via: [:patch]
    match 'medical', to: 'medical#update', via: [:patch]
    resources :user, only: [:index]
    resources :medical, only: [:index,]
    resources :reminders, only: [:index,:update]
    resources :allergies, only: [:index,:create,:update,:destroy]
    resources :medicines, only: [:index,:create,:update,:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
