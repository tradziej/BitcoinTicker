require 'rspec/core/rake_task'
require "bundler/gem_tasks"

task :console do
  exec "pry -r bitcoin_ticker -I ./lib"
end


RSpec::Core::RakeTask.new(:spec)

task :default => :spec
