# Variables
set :application, "your-app"                             # De naam van Uw applicatie
set :user, "your-user"                                   # De login-naam
set :domain, "your-domain"                          # Uw domein

set :deploy_to, "/home/#{user}/apps/#{application}"

set :rails_env, "staging"

# Servers
role :app, "your-server"
role :web, "your-server"
role :db, "your-server", :primary => true

set :assets_dirs, ['ftpexchange', 'data']

after "deploy:update_code", "assets:symlink" 
after "deploy:symlink", "deploy:update_crontab"
after "deploy:symlink", "thinking_sphinx:shared_sphinx_folder"
after "deploy:update_code", "thinking_sphinx:start"

# Lighttpd stuff
namespace :lighttpd do
    desc "Restart the web server"
    task :restart, :roles => :app do
        run "lighty restart"
    end

    desc "Stop the web server"
    task :stop, :roles => :app do
        run "lighty stop"
    end

    desc "Start the web server"
    task :start, :roles => :app do
        run "lighty start"
    end

    desc "Configure the webserver"
    task :config, :roles => :app do
       conf = <<LIGHTYCONF
### Rails Application Configuration File

$HTTP["host"] =~ "^(www.)?#{domain.gsub('.','.')}" {
  var.app                 = "#{application}"
  accesslog.filename          = base + "/logs/" + app + ".access.log"
  server.errorlog             = base + "/logs/" + app + ".error.log"

  load Rails with capistrano app
}
LIGHTYCONF
    put conf, "lighttpd/#{application}.conf"
    end
end

# Standard deploy actions overwritten
namespace :deploy do
    desc "Restart your application"
    task :restart do
        lighttpd::restart
    end

    desc "Start your application"
    task :start do
        lighttpd::start
    end

    desc "Stop your application"
    task :stop do
        lighttpd::stop
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

