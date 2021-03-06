# config valid only for current version of Capistrano
lock '3.7.1'

set :application, 'imap-api'
set :server_name, ENV['SERVER_NAME']

set :repo_url, 'git@github.com:mutalis/imap-api.git'

# Default branch is :master
set :branch, ENV['BRANCH']

set :user, ENV['SHELL_USERNAME']
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('.env')

# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/assets', 'vendor/bundle', 'public/spree')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env,
  { DB_NAME: ENV['DB_NAME'], DB_USERNAME: ENV['DB_USERNAME'], DB_PASSWORD: ENV['DB_PASSWORD'],
  DB_HOSTNAME: ENV['DB_HOSTNAME'], RAILS_MAX_THREADS: ENV['RAILS_MAX_THREADS'],
  SECRET_KEY_BASE: ENV['SECRET_KEY_BASE'] }

# Default value for keep_releases is 5
set :keep_releases, 1

# set :ssh_options, {
#   forward_agent: true,
#   port: 74
# }

# Defaults to :db role
set :migration_role, :app

set :migration_servers, -> { primary(fetch(:migration_role)) }

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

# Defaults to [:web]
set :assets_roles, [:web, :app]
