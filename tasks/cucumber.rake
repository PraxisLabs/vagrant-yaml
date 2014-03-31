require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'coveralls/rake/task'

desc 'Default task which runs all cucumber tests'
Coveralls::RakeTask.new
task :default => [:features, 'coveralls:push']
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --no-source --format pretty"
end
