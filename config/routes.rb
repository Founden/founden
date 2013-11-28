Founden::Application.routes.draw do
  resource :pages, :only => [], :path => '/' do
    get :dashboard
  end

  root :to => 'pages#dashboard'
end
