require 'spec_helper'
 
# selinuxがdisableであること
describe selinux do
  it { should be_disabled }
end

#JSTであること
describe command('date') do
  its(:stdout) { should match /JST/ }
end

# 不要サービス停止
%w{ ip6tables iptables }.each do |services|
  describe service(services) do
    it { should_not be_enabled }
    it { should_not be_running }
  end
end

#sshd関連設定
describe package('openssh-server') do
  it { should be_installed }
end

describe service('sshd') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(22) do
  it { should be_listening }
end

describe file('/etc/ssh/sshd_config') do
  it { should be_file }
  #it { should contain "PermitRootLogin forced-commands-only" }
  it { should contain "RSAAuthentication yes" }
  it { should contain "PasswordAuthentication yes" }
end
