# Start app.
execute 'Start app' do
  command <<-EOH
    supervisorctl update app
    supervisorctl start app
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/app.ini'
  end
end