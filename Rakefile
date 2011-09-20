require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => :test

desc 'Test the ActiveAdmin engine.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

Rake::TestTask.new(:"test:units") do |t|
  t.libs << 'test'
  t.pattern = 'test/unit/**/*_test.rb'
  t.verbose = true
end

Rake::TestTask.new(:"test:functionals") do |t|
  t.libs << 'test'
  t.pattern = 'test/functional/**/*_test.rb'
  t.verbose = true
end

Rake::TestTask.new(:"test:integration") do |t|
  t.libs << 'test'
  t.pattern = 'test/integration/**/*_test.rb'
  t.verbose = true
end

Rake::RDocTask.new do |rdoc|
  rdoc.title = "ActiveAdmin"
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  rdoc.options << "--charset=utf-8"
end

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    root_files = FileList["README.rdoc"]
    gem.name = "activeadmin"
    gem.version = "0.0.1"
    gem.summary = "Administration engine for Ruby on Rails."
    gem.email = "ysbaddaden@gmail.com"
    gem.homepage = "http://github.com/ysbaddaden/calliope"
    gem.description = "Administration engine for Ruby on Rails."
    gem.authors = ['Julien Portalier']
    gem.files = root_files + FileList["{lib}/*"] + FileList["{lib}/**/*"] + FileList["{app}/*"] + FileList["{app}/**/*"]
    gem.extra_rdoc_files = root_files
    gem.add_dependency 'rails', '~> 3.0'
#    gem.add_dependency 'commentable'
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: gem install jeweler"
end

