set :application, 'app.founden.com'
set :repo_url, 'git@github.com:stas/founden.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, proc { '/home/%s/%s' % [
  primary(:app).user, fetch(:application)] }
set :scm, :git

# set :format, :pretty
set :log_level, :info
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml config/bugsnag.yml config/aws.yml} +
  %w{config/settings.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets} +
  %w{vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.0.0-p353'

set :queue_classic_pid_path, proc {
  shared_path.join('tmp', 'pids', 'qc-%s' % fetch(:stage)) }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  after :finishing, 'deploy:cleanup'
  after :restart, 'puma:restart'

  namespace :check do
    task :linked_files => fetch(:linked_files)
  end
end
