Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
  resources :works, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  resources :works do
    post '/upvote', to: "votes#upvote", as: "upvote"
  end
  
  resources :users, only: [:index]
end
