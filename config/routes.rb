Rails.application.routes.draw do
  resources :list, only: [:index, :show, :new, :create]
end
