# set :application, "set your application name here"
# set :repository,  "set your repository location here"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :keep_releases, 3

set :use_sudo, false
default_run_options[:pty] = true
 
set :user, 'jcoleman'
set :server, 'weracketeer.com'
set :application, "band" 

set :repository, "git://github.com/progressions/band.git"
set :scm, "git"
set :scm_passphrase, "spuggy" #This is your custom users password

role :web, 'weracketeer.com'
role :app, 'weracketeer.com'
role :db,  'weracketeer.com', :primary => true

set :deploy_to, "/home/#{user}/#{application}" 

task :restart, :roles => :app do
end

task :restart_web_server, :roles => :web do
  # restart your web server here
end

after "deploy:start", :restart_web_server

desc "Sets appropriate permission on dispatch.cgi"
task :set_perm do
	run "chmod 755 #{application}/current/public/dispatch.cgi &&
       chmod 755 #{application}/current/public/dispatch.fcgi &&
       chmod 755 #{application}/current/public &&
       rm -f -d -r #{application}/current/public/images &&
       ln -s /home/jcoleman/band/current/public/ #{application}/current/public/band &&
       ln -s /home/jcoleman/band/shared/images/ #{application}/current/public/images"
end

desc "Runs remote:setup task on live-test folder to create the necessary directories"
task :test_setup do
	set :deploy_to, @deploy_test
	setup
end

desc "Does stuff after deployment"
task :after_deploy do
  set_perm
  # share_files
end

desc "Does stuff after a rollback"
task :after_rollback do
  set_perm
  # share_files
end
