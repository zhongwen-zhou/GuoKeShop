Rails.application.routes.draw do
  root 'welcome#index'

  # API
  namespace :api do
    get 'caipiao/latest_caipiao', to: 'caipiaos#latest_caipiao'
    post 'caipiao/push_last_result', to: 'caipiaos#push_last_result'
    post 'caipiao/bought', to: 'caipiaos#bought'
    post 'caipiao/my_money', to: 'caipiaos#my_money'
    get 'caipiao/money', to: 'caipiaos#money'
    resources :channels, :only => [] do
      resources :channel_games, :only => [:index] do
        resources :access_details, :only => [:create]
        resources :payments, :only => [:create]
      end
    end
  end

  resources :carts do
    collection do
      post :add_to_cart
      post :remove_from_cart
      get :current_carts
    end
  end

  resources :items do
    collection do
      get :category
      post :search
    end
    member do
      post :add_cut
      post :remove_cut
    end
    collection do
      delete :clear_cut
    end
  end

  resources :orders do
    collection do
      get :checkout_view
    end
    member do
      post :sent
      post :accept
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
    resources :items do
      member do
        get :move_up
        get :move_down
      end
    end
    resources :orders do
      collection do
        get :new_comming_orders
        get :new_index
        get :wait_send_index
        get :wait_done_index
        get :done_index
      end
      member do
        post :sent
        post :done
        get :print_detail_page
      end
    end
    resources :categories
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
