require 'spec_helper'

# 必要なパッケージが入っていること
%w{ git yum }.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

