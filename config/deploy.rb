require 'capistrano/ext/multistage'
require 'thinking_sphinx/deploy/capistrano'


load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# Source code
set :scm, 'git'
set :repository, "git@github.com:your-repository"                           # Uw repository

# Settings
set :use_sudo, false       # Shared environment
set :group_writable, false     # Shared environment
set :keep_releases, 4      # 4 Releases should be enough

set :assets_dirs, ['data']

namespace :assets do 
  task :symlink, :roles => :app do 
      assets.create_dirs 
      
      assets_dirs.each do |name| 
        run "rm -rf #{release_path}/#{name}" 
        run "ln -nfs #{shared_path}/#{name} #{release_path}/#{name}"
      end
    end 

  task :create_dirs, :roles => :app do 
    assets_dirs.each do |name| 
      run "mkdir -p #{shared_path}/#{name}" 
    end 
  end 
end

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

after "deploy:update_code", "assets:symlink" 
after "deploy:migrations", "deploy:cleanup"
after "deploy:symlink", "deploy:update_crontab"
after "deploy", "deploy:cleanup"


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'

begin
  require 'capfire/capistrano'
rescue Object
  # Don't force other users to install Capfire.
end

