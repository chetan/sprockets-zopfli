# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "zopfli-bin"
  gem.homepage = "http://github.com/chetan/zopfli-bin"
  gem.license = "MIT"
  gem.summary = %Q{A thin wrapper around the zoplfi binary}
  gem.description = %Q{A thin wrapper around the zoplfi binary (included as an ext)}
  gem.email = "chetan@pixelcop.net"
  gem.authors = ["Chetan Sarva"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

task :default => :test

require 'yard'
YARD::Rake::YardocTask.new
