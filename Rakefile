require "bundler/gem_tasks"
require 'rake/testtask'

## Test stuff

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

desc "Run tests"
task :default => :test

## RACC stuff

rule '.rb' => '.y' do |t|
  sh "racc -l -o #{t.name} #{t.source}"
end

task :compile => 'lib/eye_of_newt/parser.rb'

task :test => :compile
