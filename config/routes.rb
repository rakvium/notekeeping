Rails.application.routes.draw do
  resources :tags, except: %i[destroy edit update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :notes do
    member do
      get :new_tag
      post :add_tag
    end
    resources :sharings
  end
  devise_for :users
  root to: 'notes#index'
end
