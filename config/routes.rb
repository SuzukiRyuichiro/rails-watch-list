Rails.application.routes.draw do
  resources :list, only: [:index, :show, :new, :create] do
    resources :bookmark, only: [:new, :create, :destroy]
  end
end
