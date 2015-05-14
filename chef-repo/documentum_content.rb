# Need to inventory baseline to see if this is even required
#groupinstalls = ['Development tools',]
#for groupinstall in groupinstalls do
#  bash "yum groupinstalls ..." do
#    user "root"
#    group "root"
#    code <<-EOC
#      yum groupinstall "#{groupinstall}" -y
#    EOC
#  not_if "yum grouplist installed | grep \"#{groupinstall}\""
#  end
#end

# Packages
#package ['xorg-x11-xauth', '']

# Groups
group "documentum" do
  action :create
  append true
end

group 'oracle' do
  action :create
  append true
end

directory '/u01/app' do
  owner 'root'
  group 'root'
  mode '0775'
  recursive true
  action :create
end

# Users
user 'dmadmin' do
  system true
  supports :manage_home => true
  comment 'Documentum Installation Owner'
  #uid 1234 # TODO
  gid 'documentum'
  home '/u01/app/documentum'
  action :create
end

user 'exp' do
  system true
  #supports :manage_home => true
  comment 'Documentum Repository Owner'
  #uid 1235 # TODO
  gid 'documentum'
  #home ''
  action :create
end

user 'oradmin' do
  system true
  supports :manage_home => true
  comment 'Oracle Installation Owner'
  #uid 1236 # TODO
  gid 'oracle'
  home '/u01/app/oracle'
  action :create
end

return if node['visual'] == 'not_installed'

# else continue after visual installer ...

