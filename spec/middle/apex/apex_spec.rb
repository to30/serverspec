
require 'spec_helper'


###論理マスターノードの待ち受けポート番号
describe port(2011) do
  it { should be_listening }
end

###JAWS（APEXの管理画面）が利用するポート番号
describe port(8080) do
  it { should be_listening }
end

###自ノードがLoopbackで待ち受けするポート番号
describe port(9999) do
  it { should be_listening }
end
