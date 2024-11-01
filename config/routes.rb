Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :questions do
      resources :comments
    end
  end

  namespace :admin do
    get '/', to: 'pages#index', as: :home 
    get 'dashboard/index'
    resources :dashboard, only: [:index]
  end  

  resources :users

  devise_scope :user do
    authenticated :user do
      root to: 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end
