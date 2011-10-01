require 'bundler/gem_tasks'
require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  # if rubygems is being used to manage $:, require it in the tests too
  t.ruby_opts += [ '-rubygems' ] if defined?(::Gem)

  t.libs    = ['.', 'lib']
  t.pattern = 'test/*_test.rb'
  t.verbose = true
  t.warning = false
end

task :default => :test
