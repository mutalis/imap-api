# config valid only for current version of Capistrano
lock '3.7.1'

set :application, 'imap-api'
set :server_name, %w(52.206.239.91)

set :repo_url, 'git@github.com:mutalis/imap-api.git'

# Default branch is :master
set :branch, 'master'

set :user, 'ec2-user'
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
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/assets', 'vendor/bundle', 'public/spree')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

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
