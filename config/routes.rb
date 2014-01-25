Founden::Application.routes.draw do
  # Easy Auth endpoints
  # Allow only known providers to avoid exceptions.
  constraints(:provider => :google) do
    easy_auth_routes
  end
  get 'sign_in' => 'sessions#index'

  resource :pages, :only => [], :path => '/' do
    get :dashboard
    get :waiting
    patch :waiting
  end

  namespace :api, :constraints => {:format => :json} do
    namespace :v1 do
      resources(:users, :only => [:index, :show])
      resources(:conversations, :only => [:index, :show, :create])
      resources(:messages, :only => [:index, :show, :create, :update])
      resources(:attachments, :only => [:index, :show, :create, :update])
      resources(:memberships, :only => [:create])
      resources(:invitations, :only => [:index, :create, :update, :show])
      resources(:summaries, :only => [:index, :show])

      get 'socket' => 'misc#websocket'
      get 'md5' => 'misc#md5'
    end
  end

  root :to => 'pages#dashboard'
end
