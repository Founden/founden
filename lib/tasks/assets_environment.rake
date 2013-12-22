# See https://github.com/rails/rails/commit/49c4af43ec5819d8f5c1a91f9b84296c927ce6e7
namespace :assets do
  task :environment do
    Bundler.require(:assets)
    Rake::Task['environment'].invoke
  end
end
