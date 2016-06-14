require 'spec_helper'
 
# selinuxがdisableであること
describe selinux do
  it { should be_disabled }
end

# 不要サービス停止
%w{ ip6tables iptables }.each do |services|
  describe service(services) do
    it { should_not be_enabled }
    it { should_not be_running }
  end
end


