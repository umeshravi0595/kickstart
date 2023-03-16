# Install system packages.
yum_package 'Install system packages' do
  package_name [
    'wget',
    'tar',
    'gzip',
    'vim',
    'procps',
    'libcurl',
    'openssl',
    'xz-libs'
  ]
  action :install
end

# Create MongoDB directories.
[
  node['mongodb']['config_dir'],
  node['mongodb']['log_dir'],
  node['mongodb']['data_dir']
].each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    recursive true
    mode 0700
    action 'create'
    not_if do
      File.exists?dir
    end
  end
end

# Download MongoDB.
remote_file "/tmp/mongodb-linux-x86_64-amazon2-#{node['mongodb']['version']}.tgz" do
  source "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-amazon2-#{node['mongodb']['version']}.tgz"
  mode 0644
  not_if do
    File.exists?"/tmp/mongodb-linux-x86_64-amazon2-#{node['mongodb']['version']}.tgz"
  end
  not_if do
    File.exists?"/usr/local/bin/mongod"
  end
end

# Extract MongoDB.
execute 'Extract MongoDB' do
  command "tar -zxvf mongodb-linux-x86_64-amazon2-#{node['mongodb']['version']}.tgz"
  cwd '/tmp'
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"/tmp/mongodb-linux-x86_64-amazon2-#{node['mongodb']['version']}.tgz"
  end
  not_if do
    File.exists?"/usr/local/bin/mongod"
  end
end

# Copy MongoDB binaries into system binary path.
execute 'Copy MongoDB binaries into system binary path' do
  command "cp mongodb-linux-x86_64-amazon2-4.4.4/bin/* /usr/local/bin/"
  cwd '/tmp'
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"/tmp/mongodb-linux-x86_64-amazon2-#{node['mongodb']['version']}"
  end
  not_if do
    File.exists?"/usr/local/bin/mongod"
  end
end

# Cleanup source.
execute 'Cleanup source' do
  command 'rm -rf mongodb-*'
  cwd '/tmp'
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"/tmp/mongodb-linux-x86_64-amazon2-#{node['mongodb']['version']}"
  end
end


