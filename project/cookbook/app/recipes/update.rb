
module_dir = node['app']['nodejs']['module_dir']

# Install required npm packages mongodb.
execute 'Install required npm packages mongodb' do
  command ' npm install mongodb@3.6.5'
  cwd module_dir
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"#{module_dir}"
  end
end


# Install required npm packages express js.
execute 'Install required npm packages express js' do
  command ' npm install express@4.17.1'
  cwd module_dir
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"#{module_dir}"
  end
end

execute 'set nodejs path' do
  command 'export NODE_PATH=/opt/app/node_modules'

end











