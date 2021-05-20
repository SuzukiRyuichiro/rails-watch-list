Rails.application.routes.draw do
  root to: 'list#index'
  resources :lists, only: [:show, :new, :create, :index] do
    resources :bookmarks, only: [:new, :create, :destroy]
  end
end
