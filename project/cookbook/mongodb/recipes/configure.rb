config_dir = node['mongodb']['config_dir']
data_dir = node['mongodb']['data_dir']
log_dir = node['mongodb']['log_dir']

# Configure MongoDB.
template "#{config_dir}/mongod.conf" do
  source 'mongod.conf.erb'
  owner 'root'
  group 'root'
  variables(
    'log_dir'=>log_dir,
    'data_dir'=>data_dir
  )
  mode 0600
  backup false
  action 'create'
end

# Configure Supervisor for MongoDB.
template '/etc/supervisord.d/mongodb.ini' do
  source 'supervisor.ini.erb'
  owner 'root'
  group 'root'
  variables(
    'config_dir'=>config_dir
  )
  mode 0644
  backup false
  action 'create'
end
