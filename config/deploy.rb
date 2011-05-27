set :user,        'porkeypop'                       # Your dreamhost account's username
set :domain,      'anhangzhu.com'              # Dreamhost servername where your account is located
set :project,     'pmanagr'                 # Your application as its called in the repository
set :application, 'pmanagr.anhangzhu.com'         # Your app's location (domain or sub-domain name as setup in panel)
set :directory,   "/home/#{user}/#{application}" # The standard Dreamhost setup

# Default Environment Variables
default_environment["GEM_PATH"] = "/home/#{user}/.gems:/usr/lib/ruby/gems/1.8"

# Version Control Configuration
set :repository, "http://pmanagr.googlecode.com/svn/trunk/"

# Roles (Servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# Deploy Configuration
set :deploy_to,  directory
set :deploy_via, :export

# Additional Settings
default_run_options[:pty] = true                 # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/Path/To/id_rsa)        # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

# Passenger Configuration
namespace :deploy do
  

  
  [:start, :stop].each do |t| 
    task t do; end 
  end
  desc "Restarts your application."
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
  

end