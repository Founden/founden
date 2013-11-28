Founden::Application.routes.draw do
  # Easy Auth endpoints
  # Allow only Angel List to avoid exceptions.
  constraints(:provider => :google) do
    easy_auth_routes
  end
  get 'sign_in' => 'sessions#index'

  resource :pages, :only => [], :path => '/' do
    get :dashboard
  end

  root :to => 'pages#dashboard'
end
