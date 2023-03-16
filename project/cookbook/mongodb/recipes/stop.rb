# Stop MongoDB.
execute 'Stop MongoDB' do
  command <<-EOH
    supervisorctl stop mongodb
    supervisorctl remove mongodb
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/mongodb.ini'
  end
end