# -*- ruby -*-

require "rubygems"

gem 'hoe'
require "hoe"
Hoe.plugin :git
Hoe.plugin :gemspec
Hoe.plugin :bundler
Hoe.plugin :yard

Hoe.spec "yamlr" do
  developer('Step1Profit', 'sales@step1profit.com')

  license "MIT"

  self.extra_dev_deps += [
    ["hoe-bundler",               ">= 1.1"],
    ["hoe-gemspec",               ">= 1.0"],
    ["hoe-git",                   ">= 1.4"],
    ["minitest",                  "~> 2.2.2"],
    ["codeclimate-test-reporter", ">= 0.4"],
  ]

  self.testlib = :minitest
end

# vim: syntax=ruby
