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

  namespace :api, :constraints => {:format => :json} do
   namespace :v1 do
     resources(:users, :only => [:index, :show])
   end
  end

  root :to => 'pages#dashboard'
end
