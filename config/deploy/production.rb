# Variables
set :application, "your-app"                             # De naam van Uw applicatie
set :user, "your-user"                                   # De login-naam
set :domain, "your-domain"                          # Uw domein

set :deploy_to, "/srv/data_chionides/vti/apps/vti/"

# Servers
role :app, "your-server"
role :web, "your-server"
role :db,  "your-server", :primary => true

set :assets_dirs, ['ftpexchange', 'data']

after "deploy:update_code", "assets:symlink" 
after "deploy:symlink", "deploy:update_crontab"
after "deploy:symlink", "thinking_sphinx:shared_sphinx_folder"
after "deploy:update_code", "thinking_sphinx:stop"
after "deploy:update_code", "thinking_sphinx:start"

# passenger config
namespace :passenger do
    desc "Restart the web server"
    task :restart, :roles => :app do
        run "touch #{current_release}/tmp/restart.txt"
    end

    [:start, :stop].each do |t|
        desc "#{t} task is a no-op with passenger"
        task t, :roles => :app do ; end
    end
end


namespace :deploy do
    desc "Update the crontab file"
    task :update_crontab, :roles => :db do
      run "cd #{release_path} && ruby #{release_path}/vendor/gems/javan-whenever-0.3.0/bin/whenever --load-file config/schedules/production.rb --update-crontab #{application}"
    end

    desc "Restart your application"
    task :restart do
        passenger::restart
    end

    desc "Start your application"
    task :start do
        passenger::start
    end

    desc "Stop your application"
    task :stop do
        passenger::stop
    end
end

namespace :assets do 
  task :symlink, :roles => :app do 
      assets.create_dirs 
      
      assets_dirs.each do |name| 
        run "ln -nfs #{shared_path}/#{name} #{release_path}/#{name}"
      end
    end 

  task :create_dirs, :roles => :app do 
    assets_dirs.each do |name| 
      run "mkdir -p #{shared_path}/#{name}" 
    end 
  end 
end 
