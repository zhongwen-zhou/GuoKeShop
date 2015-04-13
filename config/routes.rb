Rails.application.routes.draw do
  root 'welcome#index'

  # API
  namespace :api do
    resources :channels, :only => [] do
      resources :channel_games, :only => [:index] do
        resources :access_details, :only => [:create]
        resources :payments, :only => [:create]
      end
    end
  end

  # 渠道用户  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :channels, :only => [:show] do
    member do
      get :edit_password
      post :update_password
    end
    resources :channel_games, :only => [:index] do
      collection do
        get :query
      end
      # resources :access_details, :only => [:index]
      # resources :payments, :only => [:index]
    end
  end

  # 网站后台
  namespace :admin do
    root 'welcome#index'
    resources :games do
      member do
        get :channel_detail
        get :query_channel_detail
      end
      collection do
        get :query
      end
    end
    resources :users do
      member do
        get :edit_password
        post :update_password
      end
    end
    resources :channels do
      resources :channel_games, :only => [:index, :new, :create, :destroy] do
        member do
          get :edit_config
          post :update_config
        end
      end
    end
    resources :sessions, :only => [:new, :create, :destroy]
  end
end
