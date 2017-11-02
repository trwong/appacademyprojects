Rails.application.routes.draw do
  get 'comments/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:index, :create, :new]
  end
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create]
end
