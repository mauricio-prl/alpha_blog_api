Rails.application.routes.draw do
  root 'api/v1/welcome#home'
  
  namespace :api do
    namespace :v1 do
      # resources :articles
      get '/about', to: 'welcome#about'
    end
  end
end
