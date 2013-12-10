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
     resources(:networks, :only => [:index, :show])
     resources(:conversations, :only => [:index, :show, :create])
     resources(:messages, :only => [:index, :show, :create])
   end
  end

  root :to => 'pages#dashboard'
end
