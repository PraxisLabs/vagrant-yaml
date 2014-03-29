source "http://rubygems.org"


group :development do
  ruby "2.1.1"
  gem "vagrant", :git => "https://github.com/mitchellh/vagrant.git" #, :tag => 'v1.5.1'
end

group :plugins do
  gem "vagrant-yaml", path: "."
end

group :test do
  #gem "vagrant", :git => "https://github.com/mitchellh/vagrant.git" #, :tag => 'v1.5.1'
  gem "cucumber"
  gem "aruba"
  gem "rake"
  gem 'coveralls', require: false
end
