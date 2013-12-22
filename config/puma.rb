threads 1,1
workers 1
# Uncomment this if starting a cluster
# preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
