Rails.application.routes.draw do
  
  namespace :api do
    get 'auth/register'
    get 'auth/login'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
