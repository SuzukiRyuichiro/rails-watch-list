Rails.application.routes.draw do
  root to: 'lists#index'
  resources :lists, only: [:show, :new, :create, :index] do
    resources :bookmarks, only: [:new, :create, :destroy]
  end
end
