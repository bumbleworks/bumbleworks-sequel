# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bumbleworks/sequel/version'

Gem::Specification.new do |spec|
  spec.name          = "bumbleworks-sequel"
  spec.version       = Bumbleworks::Sequel::VERSION
  spec.authors       = ["Ravi Gadad"]
  spec.email         = ["ravi@renewfund.com"]
  spec.description   = %q{Sequel support for Bumbleworks process storage}
  spec.summary       = %q{This gem allows you to use any of a number of RDBMSes (via the Sequel ORM) for your Bumbleworks process storage.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
