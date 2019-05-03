Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :show] do
    resources :goals, only: [:edit, :update, :new, :create, :destroy]
  end
  resources :goals, only: [:show, :index]
  resource  :session, only: [:new, :create, :destroy]

end
