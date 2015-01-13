set :stage, :development
set :branch, "master"

set :domain, "54.69.164.109" 

role :app, "54.69.164.109"

set :deploy_to, "/var/www/rhea_web_app"
set :application_path, "/var/www/rhea_web_app"
set :rails_env, "development"

server '54.69.164.109',
       user: 'ec2-user'
