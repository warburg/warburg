# Variables
set :application, "your-app"                             # De naam van Uw applicatie
set :user, "your-user"                                   # De login-naam

set :deploy_to, "/root/#{application}"

set :rails_env, "migration"

# Servers
role :app, "your-server"
role :web, "your-server"
role :db,  "your-server", :primary => true

after "deploy:symlink", "deploy:update_crontab"

namespace :deploy do

  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && ruby #{release_path}/vendor/gems/javan-whenever-0.3.0/bin/whenever --load-file config/schedules/migration.rb --update-crontab #{application}"
  end

  desc "Restart your application"
  task :restart do
  end

  desc "Start your application"
  task :start do
  end

  desc "Stop your application"
  task :stop do
  end
end
