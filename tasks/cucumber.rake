require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

desc 'Default task which runs all cucumber tests'
task :default => [:features]

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --no-source --format pretty"
end
