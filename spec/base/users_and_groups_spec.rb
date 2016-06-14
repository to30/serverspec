require 'spec_helper'

# login users のテスト
%w{ glassfish tomo }.each do |u|
  describe user(u) do
    it { should exist }
    it { should_not belong_to_group 'wheel' }
  end
end

