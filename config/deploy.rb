set :user, "root"
set :application, "ec2-75-101-252-188.compute-1.amazonaws.com"
set :repository,  "https://pmanagr.googlecode.com/svn/trunk/"
set :ssh_options, {:forward_agent => true}
set :deploy_to, "/#{user}/pmanagr"
set :machine_name, "ec2-75-101-252-188.compute-1.amazonaws.com"

set :scm, :subversion
set :scm_username, "anhang"
set :scm_password, "MC3Vv8Bz2aJ2"

role :app, "#{machine_name}"
role :web, "#{machine_name}"
role :db,  "#{machine_name}", :primary => true

set :use_sudo, false

namespace :deploy do
  %w(start stop restart).each do |action| 
     desc "#{action} the Thin processes"  
     task action.to_sym do
       find_and_execute_task("thin:#{action}")
    end
  end 
end

namespace :thin do  
  %w(start stop restart).each do |action| 
  desc "#{action} the app's Thin Cluster"  
    task action.to_sym, :roles => :app do  
      run "thin #{action} -d -c #{deploy_to}/current -e production -p 80" 
    end
  end
end