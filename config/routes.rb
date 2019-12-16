Rails.application.routes.draw do
  root 'api/v1/welcome#home'
  
  namespace :api do
    namespace :v1 do
      resources :articles
      resources :users, except: [:create]
      get 'about', to: 'welcome#about'
      post 'signup', to: 'users#create'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
    end
  end
end
