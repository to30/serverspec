require 'spec_helper'

# syslog設定
describe file('/etc/logrotate.d/syslog') do
  it { should contain 'messages' }
  it { should contain 'secure' }
end

