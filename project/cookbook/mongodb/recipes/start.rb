# Start MongoDB.
execute 'Start MongoDB' do
  command <<-EOH
    supervisorctl update mongodb
    supervisorctl start mongodb
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/mongodb.ini'
  end
end