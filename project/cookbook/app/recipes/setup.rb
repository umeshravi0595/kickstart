deploy_dir = node['app']['deploy_dir']
log_dir = node['app']['log_dir']
nodejs_version = node['app']['nodejs']['version'] 
module_dir = node['app']['nodejs']['module_dir']
exec_dir = node['app']['nodejs']['exec_dir']


yum_package 'install system packages' do
  package_name         ['wget', 'vim', 'procps', 'tar', 'gzip', 'xz']
  action                :install 
end

remote_file "/tmp/node-#{nodejs_version}-linux-x64.tar.xz" do
  source "https://nodejs.org/dist/#{nodejs_version}/node-#{nodejs_version}-linux-x64.tar.xz"
  owner 'root'
  group 'root'
  mode '0755'
  not_if do
    File.exists?"/tmp/node-v14.16.0-linux-x64.tar"
  end
end


# Create directories
[
  node['app']['deploy_dir'],
  node['app']['log_dir'],
  node['app']['nodejs'] ['module_dir'],
  node['app']['nodejs'] ['exec_dir']
].each do |dir|
directory dir do
  group 'root'
  owner 'root'
  mode  0700                
  recursive  true
  action  'create'
  not_if do 
    File.exists?dir
    end
end
end


execute 'extract the tarball' do
  command       "tar -xJvf node-#{nodejs_version}-linux-x64.tar.xz -C #{exec_dir}"
  cwd            '/tmp'
  group           'root'
  returns         [0]
  user            'root'
  action          'run'
  only_if do 
  File.exists?"/tmp/node-#{nodejs_version}-linux-x64.tar.xz"
  end
  not_if do
  File.exists?"#{exec_dir}/node-#{nodejs_version}-linux-x64.tar"
end
  end

execute 'remove the tar file from /tmp' do
  command       "rm -f node-#{nodejs_version}-linux-x64.tar.xz"
  cwd            '/tmp'
  group           'root'
  returns         [0]
  user            'root'
  action          'run'
  only_if do 
  File.exists?"/tmp/node-#{nodejs_version}-linux-x64.tar.xz"
  end
  end

  execute 'set nodejs path' do
  command 'export PATH=/usr/local/lib/nodejs/node-v14.16.0-linux-x64/bin:$PATH'
  environment ({'PATH' => "/usr/local/lib/nodejs/node-v14.16.0-linux-x64/bin:#{ENV['PATH']}"})
end
