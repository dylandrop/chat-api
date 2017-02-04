Rails.application.routes.draw do
  resources :sessions, only: %i(create)
  resources :messages, only: %i(create index)
end
