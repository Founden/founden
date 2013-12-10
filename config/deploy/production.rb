set :stage, :production
set :branch, 'master'
set :rails_env, :production

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w{deployer@staging.founden.com:8000}
role :web, %w{deployer@staging.founden.com:8000}
role :db,  %w{deployer@staging.founden.com:8000}
