Rails.application.routes.draw do
  root 'api/v1/welcome#home'
  
  namespace :api do
    namespace :v1 do
      get '/about', to: 'welcome#about'
      resources :articles
      resources :users, except: [:create]
      resources :categories
      post 'signup', to: 'users#create'
    end
  end
end
