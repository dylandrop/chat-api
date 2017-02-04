Rails.application.routes.draw do
  resources :sessions, only: %i(create)
end
