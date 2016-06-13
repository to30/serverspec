require 'spec_helper'

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
 
 

