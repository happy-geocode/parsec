#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rspec"
require "rspec/core/rake_task"

namespace :spec do
  desc "acceptance tests"
  RSpec::Core::RakeTask.new(:acceptance) do |spec|
    spec.pattern = "spec/acceptance/*_spec.rb"
  end

  desc "integration tests"
  RSpec::Core::RakeTask.new(:integration) do |spec|
    spec.pattern = "spec/integration/*_spec.rb"
  end
end

task :default => ["spec:acceptance, spec:integration"]
