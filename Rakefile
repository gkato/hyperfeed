#!/usr/bin/env rake
require 'rubygems'
require "bundler/gem_tasks"
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

begin
  require "bundler/gem_tasks"
  require 'bundler/setup'
rescue LoadError => e
  puts e
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

task :default => :spec
RSpec::Core::RakeTask.new(:spec)
