deploy_dir = node['app']['deploy_dir']
log_dir = node['app']['log_dir']
nodejs_version = node['app']['nodejs']['version'] 
exec_dir = node['app']['nodejs']['exec_dir']

# copy source code of app from local to container.
template "#{deploy_dir}/init.js" do
  source 'init.erb'
  owner 'root'
  group 'root'
   variables(
    'deploy_dir'=>deploy_dir,
    'nodejs_version'=> nodejs_version,
    'exec_dir'=>exec_dir,
    'log_dir'=>log_dir
  )
  mode 0644
  backup false
  action 'create'
end


# Configure Supervisor for App.
template '/etc/supervisord.d/app.ini' do
  source 'supervisor.ini.erb'
  owner 'root'
  group 'root'
  variables(
    'deploy_dir'=>deploy_dir,
    'nodejs_version'=> nodejs_version,
    'exec_dir'=>exec_dir,
    'log_dir'=>log_dir
  )
  mode 0644
  backup false
  action 'create'
end




