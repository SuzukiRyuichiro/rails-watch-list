Rails.application.routes.draw do
  root to: 'list#index'
  resources :list, only: [:index, :show, :new, :create] do
    resources :bookmark, only: [:new, :create, :destroy]
  end
end
