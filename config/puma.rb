# This configuration file will be evaluated by Puma. The top-level methods that
# are invoked here are part of Puma's configuration DSL. For more information
# about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html.
#
# Puma starts a configurable number of processes (workers) and each process
# serves each request in a thread from an internal thread pool.
#
# You can control the number of workers using ENV["WEB_CONCURRENCY"]. You
# should only set this value when you want to run 2 or more workers. The
# default is already 1.
#
# The ideal number of threads per worker depends both on how much time the
# application spends waiting for IO operations and on how much you wish to
# prioritize throughput over latency.
#
# As a rule of thumb, increasing the number of threads will increase how much
# traffic a given process can handle (throughput), but due to CRuby's
# Global VM Lock (GVL) it has diminishing returns and will degrade the
# response time (latency) of the application.
#
# The default is set to 3 threads as it's deemed a decent compromise between
# throughput and latency for the average Rails application.
#
# Any libraries that use a connection pool or another resource pool should
# be configured to provide at least as many connections as the number of
# threads. This includes Active Record's `pool` parameter in `database.yml`.

# workers Integer(ENV.fetch("WEB_CONCURRENCY") { 2 })
# max_threads_count = Integer(ENV.fetch("RAILS_MAX_THREADS") { 5 })
# min_threads_count = Integer(ENV.fetch("RAILS_MIN_THREADS") { max_threads_count })
# threads min_threads_count, max_threads_count

# preload_app!

# port ENV.fetch("PORT") { 3000 }

# environment ENV.fetch("RAILS_ENV") { "development" }

# on_worker_boot do
#   ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
# end

# plugin :tmp_restart

# # Run the Solid Queue supervisor if enabled
# plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# # Specify the PID file if requested
# pidfile ENV["PIDFILE"] if ENV["PIDFILE"]

# First determine the environment
rails_env = ENV.fetch("RAILS_ENV") { "development" }

# Set workers based on environment
if rails_env == "development" && RUBY_PLATFORM =~ /darwin/
  # Running on macOS in development - use single worker mode for fork safety
  puts "Detected macOS development environment - disabling workers for fork safety"
  workers 0
else
  # For production (Heroku) or non-macOS development, use multiple workers
  workers Integer(ENV.fetch("WEB_CONCURRENCY") { 2 })
end

max_threads_count = Integer(ENV.fetch("RAILS_MAX_THREADS") { 5 })
min_threads_count = Integer(ENV.fetch("RAILS_MIN_THREADS") { max_threads_count })
threads min_threads_count, max_threads_count

preload_app!

environment rails_env

port ENV.fetch("PORT") { 3000 }

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

plugin :tmp_restart

# Run the Solid Queue supervisor if enabled
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# Specify the PID file if requested
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]