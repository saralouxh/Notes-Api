Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :users do
    post :login
    post :signup
    get :me
    delete :logout
  end
  resources :notes do
    collection do
      get :search
    end
  end
  
end
