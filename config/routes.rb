Rails.application.routes.draw do
  resources :users, only: []
  resource :session, only: [:new, :create, :destroy]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        post :login, on: :collection
      end
      resources :bank_accounts, only: [] do
        post 'deposit', on: :member
        post 'withdraw', on: :member
      end
    end
  end


  get '/transaction_history', to: 'transactions#index', as: :transaction_history
end
