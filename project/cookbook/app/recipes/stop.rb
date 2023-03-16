# Stop app.
execute 'Stop app' do
  command <<-EOH
    supervisorctl stop app
    supervisorctl remove app
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/app.ini'
  end
end