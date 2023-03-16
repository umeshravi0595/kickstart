#default attributes

default['app']['environment']= 'dev'
default['app']['deploy_dir']= '/opt/app/source'
default['app']['log_dir']= '/opt/app/log'
default['app']['nodejs']= {
  'version'=> 'v14.16.0',
  'module_dir'=> '/opt/app',
  'exec_dir' => '/usr/local/lib/nodejs'
}

