# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'table_beet/version'

Gem::Specification.new do |gem|
  gem.name          = "table_beet"
  gem.version       = TableBeet::VERSION
  gem.authors       = ["Wataru MIYAGUNI"]
  gem.email         = ["gonngo@gmail.com"]
  gem.description   = %q{Reference generator for Turnip steps of exists}
  gem.summary       = %q{Reference generator for Turnip steps of exists}
  gem.homepage      = "https://github.com/gongo/table_beet"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'turnip'
  gem.add_dependency 'slop'
  gem.add_dependency 'method_source'
  gem.add_development_dependency 'debugger'
  gem.add_development_dependency 'guard-rspec'
end
