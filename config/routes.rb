require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :company, only: [:index, :show]
      resources :article, only: [:index, :show]
      resources :service, only: :index
      resources :city, only: :index
      resources :service_price, only: :index
      resource :session_company, only: :create
      resource :client_session, only: :create
    end
  end

  scope module: :web do
    root to: 'welcome#index'

    namespace :admin do
      resource :session, only: [:new, :create, :destroy]
      root 'welcome#index'
      resources :admins do
        put 'restore'
        put 'del'
      end
      resources :companies do
        put 'restore'
        put 'del'
      end
      resources :clients do
        put 'restore'
        put 'delete'
        collection do
          get 'export'
        end
      end
      resources :orders, except: :new do
        put 'activate'
        put 'reject'
        put 'complete'
      end
      resources :cities
      resources :articles
      resources :services
      resources :service_prices do
        put 'restore'
        put 'del'
        put 'disable'
      end
        resources :reports do
        put 'delete'
      end
    end
    namespace :company do
      resource :session, only: [:new, :create, :destroy]
      resource :profile, only: [:show, :edit, :update]
      resources :orders, only: [:index, :show] do
        put 'activate'
        put 'reject'
        put 'complete'
      end
    end
    namespace :client do
      resource :profile, only: %i[show edit update]
      resource :session, only: %i[new create destroy]
      resources :orders, except: :delete
    end
    namespace :blog do
      resources :articles, only: %i[index show]
    end
  end
end
