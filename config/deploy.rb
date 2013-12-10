set :application, 'app.founden.com'
set :repo_url, 'git@github.com:stas/founden.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, proc { '/home/deployer/%s' % fetch(:application) }
set :scm, :git

# set :format, :pretty
set :log_level, :info
set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.0.0-p353'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  after :finishing, 'deploy:cleanup'
  after :restart, 'puma:restart'

  namespace :check do
    task :linked_files => 'config/database.yml'
  end
end


remote_file 'config/database.yml' => '/tmp/database.yml', :roles => :app
file '/tmp/database.yml' do |t|
  tmp_db_file = File.new(t.name, 'w')

  ask :db_config_roles, :app
  ask :db_adapter, 'postgresql'
  ask :db_host, '127.0.0.1'
  ask :db_port, 5432
  ask :db_name, fetch(:application)
  ask :db_username, 'postgres'
  ask :db_password, ''
  ask :db_pool, 5

  db_config = { fetch(:stage).to_s => {
    'adapter' => fetch(:db_adapter),
    'host' => fetch(:db_host),
    'port' => fetch(:db_port).to_i,
    'encoding' => 'unicode',
    'database' => fetch(:db_name),
    'username' => fetch(:db_username),
    'password' => fetch(:db_password),
    'timeout' => 5000,
    'pool' => fetch(:db_pool).to_i,
  } }

  tmp_db_file.write(db_config.to_yaml)
  tmp_db_file.close
end
