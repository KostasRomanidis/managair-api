Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: 'api' do
    namespace :v1, constraints: ApiConstraint.new(version: 1) do
      post 'signup', to: 'users#create'
      get 'users', to: 'users#index'
      resources :products, :customers do
        resources :purchases
      end
    end
  end
  post '/auth/login', to: 'authentication#authenticate'
  # mount Knock::Engine => "/knock"
end
