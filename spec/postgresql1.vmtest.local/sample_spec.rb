require 'spec_helper'

#hostsファイルが必要なサーバ情報を持っていること
describe file('/etc/hosts') do
  it { should contain '192.168.0.119  postgresql1.vmtest.local  postgresql1' }
  it { should contain '192.168.0.120  postgresql2.vmtest.local  postgresql2' }
  it { should contain '192.168.0.118  elastic.vmtest.local      elastic' }
  it { should contain '192.168.0.117  jenkins.vmtest.local      jenkins' }
end



#デフォルトゲートウェイの設定
describe default_gateway do
  its(:ipaddress) { should eq '192.168.0.1' }
  its(:interface) { should eq 'eth0' }
end

# selinuxがdisableであること
describe selinux do
  it { should be_disabled }
end

 
# 必要なパッケージが入っていること
%w{ git yum }.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end
 
# 不要サービス停止
%w{ ip6tables iptables }.each do |services|
  describe service(services) do
    it { should_not be_enabled }
    it { should_not be_running }
  end
end
 
# syslog設定
describe file('/etc/logrotate.d/syslog') do
  it { should contain 'messages' }
  it { should contain 'secure' }
end
 

##PostgreSQL固有の設定

describe package('postgresql92-server-9.2.17'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('postgresql92-libs-9.2.17'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('postgresql-9.2'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end


describe port(5432) do
  it { should be_listening }
end

describe file('/var/lib/pgsql/9.2/data/postgresql.conf') do 
  it { should be_file } 
  it { should be_mode 600 } 
  it { should be_owned_by 'postgres' } 
  it { should be_grouped_into 'postgres' } 
  its(:content) { should match /^listen_addresses = '*'/ } 
#  its(:content) { should match /^max_connections = 100/ } 
#  its(:content) { should match /^max_prepared_transactions = 10/ } 
  its(:content) { should match /^port = 5432/ } 
#  its(:content) { should match /^max_pool_size = 100/ } 
#  its(:content) { should match /^min_pool_size = 1/ } 
end
 
 

