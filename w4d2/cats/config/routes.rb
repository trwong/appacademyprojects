Rails.application.routes.draw do
  # get 'cat_rental_requests/new'

  # get 'cats/index'
  #
  # get 'cats/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cats
  resources :cat_rental_requests, only: [:new, :create]

end
