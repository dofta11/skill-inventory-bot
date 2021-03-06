# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

set :application, "devops-bot"
set :repo_url, "git@github.com:nbtpartners/devops-bot.git"

set :user,            'devops'
set :linked_files, %w{.env db/production.sqlite3}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :puma_threads,    [2, 4]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/var/www/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
set :branch,          ENV['BRANCH'] || "master"
# set :format,        :pretty
set :log_level,     :debug
set :keep_releases, 5

set :sidekiq_default_hooks => true
set :sidekiq_pid => File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid') # ensure this path exists in production before deploying.
set :sidekiq_env => fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
set :sidekiq_log => File.join(shared_path, 'log', 'sidekiq.log')
# set :sidekiq_options => nil
# set :sidekiq_require => nil
# set :sidekiq_tag => nil
# set :sidekiq_config => nil # if you have a config/sidekiq.yml, do not forget to set this.
# set :sidekiq_queue => nil
set :sidekiq_timeout => 10
set :sidekiq_roles => :app
set :sidekiq_processes => 1
# set :sidekiq_options_per_process => nil
# set :sidekiq_concurrency => nil
# sidekiq monit
# set :sidekiq_monit_templates_path => 'config/deploy/templates'
# set :sidekiq_monit_conf_dir => '/etc/monit/conf.d'
# set :sidekiq_monit_use_sudo => true
# set :monit_bin => '/usr/bin/monit'
# set :sidekiq_monit_default_hooks => true
# set :sidekiq_monit_group => nil
# set :sidekiq_service_name => "sidekiq_#{fetch(:application)}_#{fetch(:sidekiq_env)}" + (index ? "_#{index}" : '')

# set :sidekiq_cmd => "#{fetch(:bundle_cmd, "bundle")} exec sidekiq" # Only for capistrano2.5
# set :sidekiqctl_cmd => "#{fetch(:bundle_cmd, "bundle")} exec sidekiqctl" # Only for capistrano2.5
# set :sidekiq_user => nil #user to run sidekiq as


## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end

#   before :start, :make_dirs
# end

# namespace :deploy do
#   desc "Make sure local git is in sync with remote."
#   task :check_revision do
#     on roles(:app) do
#       unless `git rev-parse HEAD` == `git rev-parse origin/master`
#         puts "WARNING: HEAD is not the same as origin/master"
#         puts "Run `git push` to sync changes."
#         exit
#       end
#     end
#   end

#   desc 'Initial Deploy'
#   task :initial do
#     on roles(:app) do
#       before 'deploy:restart', 'puma:start'
#       invoke 'deploy'
#     end
#   end

#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       invoke 'puma:restart'
#     end
#   end

#   before :starting,     :check_revision
#   after  :finishing,    :compile_assets
#   after  :finishing,    :cleanup
#   after  :finishing,    :restart
# end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma

# # set :gce_config, 'config/gce.yml'
# set :gce_project_tag, 'Project'
# set :gce_roles_tag, 'Roles'
# set :gce_stages_tag, 'Stages'

# set :gce_project_id, 'cashslide-dev'
# set :gce_zone, %w[asia-northeast1-a]
# set :gce_filter, '(status eq "RUNNING")'
# # set :gce_fields, nil
# set :gce_secret_config, 'config/credentials.json'
# # set :gce_scope, %w[https://www.googleapis.com/auth/compute]
# # set :gce_contact_point, nil # nat_ip, network_ip

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
