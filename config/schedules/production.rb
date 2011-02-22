# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Learn more: http://github.com/javan/whenever

set :path, '/home/vti/apps/vti/current/'
set :environment, 'production'

every 1.day, :at => '11:30 pm' do
  command "#{path}script/export_library.rb production"
end

every 1.day, :at => '10:30 pm' do
  command "#{path}script/export_venues.rb production"
end

# every 1.day, :at => '1:30 am' do
#   command "#{path}script/generate_indices.rb production"
# end

every 1.day, :at => '0:30 am' do
  runner 'IdMapper.execute'
end