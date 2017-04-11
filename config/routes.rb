Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: 'api' do
    namespace :v1, constraints: ApiConstraint.new(version: 1) do
      resources :products, :customers do
        resources :purchases
      end
    end
  end
  post '/auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  get 'users', to: 'users#index'
end
