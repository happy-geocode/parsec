#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rspec"
require "rspec/core/rake_task"

namespace :spec do
  desc "Acceptance Tests"
  RSpec::Core::RakeTask.new(:acceptance) do |spec|
    spec.pattern = "spec/acceptance/*_spec.rb"
  end
end

task :default => ["spec:acceptance"]
