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
threads_count = ENV.fetch("RAILS_MAX_THREADS", 3)
threads threads_count, threads_count

# Set the correct environment for Elastic Beanstalk (defaulting to production)
environment ENV.fetch("RAILS_ENV") { "production" }

# This is critical - explicitly tell Puma where to find your app
directory '/var/app/current'

# This is also critical - tell Puma to use your config.ru file
rackup '/var/app/current/config.ru'

# Add socket binding for Elastic Beanstalk
bind "unix:///var/run/puma/my_app.sock"

# Add a single worker to handle socket file
workers 1

# Ensure proper socket permissions (now will run because we have a worker)
on_worker_boot do
  require 'fileutils'
  FileUtils.mkdir_p('/var/run/puma')
  FileUtils.touch('/var/run/puma/my_app.sock')
  File.chmod(0777, '/var/run/puma/my_app.sock')
end

# Clean up socket on shutdown
on_worker_shutdown do
  require 'fileutils'
  FileUtils.rm_f('/var/run/puma/my_app.sock') if File.exist?('/var/run/puma/my_app.sock')
end

# Preload the application for better performance
preload_app!

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Run the Solid Queue supervisor inside of Puma for single-server deployments
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# Specify the PID file if requested
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
