# Based on
# https://github.com/puma/puma/blob/master/examples/config.rb

# Configure “min” to be the minimum number of threads to use to answer
# requests and “max” the maximum.
#
# The default is “0, 16”.
#
threads 0, 1

# === Cluster mode ===

# How many worker processes to run.
#
# The default is “0”.
#
# workers 0

# If you're running in Clustered Mode you can optionally choose to preload
# your application before starting up the workers.
# This is necessary in order to take advantate of the Copy on Write feature
# introduced in MRI Ruby 2.0.
#
# The default does not preload the application.
#
# preload_app!
