# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Learn more: http://github.com/javan/whenever

set :path, '/root/vti/current'
set :environment, 'migration'

every :sunday, :at => '1:30 am' do
  runner 'Backup.backup_production'
end