require 'spec_helper'
 
#デフォルトゲートウェイの設定
describe default_gateway do
  its(:ipaddress) { should eq '192.168.0.1' }
  its(:interface) { should eq 'eth0' }
end

