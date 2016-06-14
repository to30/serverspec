require 'rake'
require 'rspec/core/rake_task'
#require 'ci/reporter/rake/rspec'

hosts = [
  {
    :name  => 'postgresql1.vmtest.local',
    :roles => %w( base production db ),
  },
  {
    :name  => 'postgresql2.vmtest.local',
    :roles => %w( base production db ),
  },
]


hosts = hosts.map do |host|
  {
    :name       => host[:name],
    :short_name => host[:name].split('.')[0],
    :roles      => host[:roles],
  }
end

desc "Run serverspec to all hosts"
task :serverspec => 'serverspec:all'

namespace :serverspec do
  task :all => hosts.map {|h| 'serverspec:' + h[:short_name] }
  hosts.each do |host|
    desc "Run serverspec to #{host[:name]}"
    RSpec::Core::RakeTask.new(host[:short_name].to_sym) do |t|
      ENV['TARGET_HOST'] = host[:name]
        if ENV['CI_FLAG']
          t.rspec_opts = "--format RspecJunitFormatter --out report/serverspec/results_#{host[:name]}.xml"
        end
      t.pattern = 'spec/{' + host[:roles].join(',') + '}/*_spec.rb'
    end
  end
end

