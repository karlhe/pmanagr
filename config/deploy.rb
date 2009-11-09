set :user, "root"
set :application, "ec2-75-101-252-188.compute-1.amazonaws.com"
set :repository,  "https://pmanagr.googlecode.com/svn/trunk/"
set :ssh_options, {:forward_agent => true}
set :deploy_to, "/#{user}/pmanagr"

set :scm, :subversion
set :scm_username, "anhang"
set :scm_password, "MC3Vv8Bz2aJ2"

role :app, application
role :web, application
role :db,  application, :primary => true

set :use_sudo, false

namespace :mod_rails do
  desc <<-DESC
  Restart the application altering tmp/restart.txt for mod_rails.
  DESC
  task :restart, :roles => :app do
    run "touch  #{release_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do mod_rails.restart end }
end