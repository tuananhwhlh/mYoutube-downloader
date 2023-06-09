Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  get  'watch', to: 'home#index'

  resources :videos, only: %i[new] do
    collection do
      post :go_to_watch
      post :download
    end
  end
end
