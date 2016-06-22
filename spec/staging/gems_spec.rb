
require 'spec_helper'

#gemで入れたbundlerのバージョンが1.12.5であることを確認
describe package('bundler') do
  it { should be_installed.by('gem').with_version('1.12.5') }
end

#fluentプラグインの確認
#plugins = %w(config-expander datacounter numeric-counter zabbix forest)
#plugins.each do |plugin|
#  describe package("fluent-plugin-#{plugin}") do
#    let(:path) { '/usr/lib64/fluent/ruby/bin:$PATH' }
#    it { should be_installed.by(:gem) }
#  end
#end


