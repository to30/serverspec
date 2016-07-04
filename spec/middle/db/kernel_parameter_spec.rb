require 'spec_helper'

##PostgreSQL固有のkernel_parameter設定

describe 'Linux kernel parameters' do
  context linux_kernel_parameter('net.ipv4.tcp_syncookies') do 
    its(:value) { should eq 1 }
  end

  context linux_kernel_parameter('kernel.shmall') do
    its(:value) { should be >= 4294967296 }
  end

  context linux_kernel_parameter('kernel.shmmax') do
    its(:value) { should be <= 68719476736 }
  end

  context linux_kernel_parameter('net.ipv4.tcp_wmem') do
    its(:value) { should match /4096\t16384\t4194304/ }
  end
end
 
