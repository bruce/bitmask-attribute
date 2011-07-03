# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bitmask_attributes/version"

Gem::Specification.new do |gem|
  gem.name          = "bitmask_attributes"
  gem.summary       = %Q{Simple bitmask attribute support for ActiveRecord}
  gem.description   = %Q{Simple bitmask attribute support for ActiveRecord}
  gem.email         = "joel@developwithstyle.com"
  gem.homepage      = "http://github.com/joelmoss/bitmask_attributes"
  gem.authors       = ['Joel Moss']
  
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
  gem.version       = BitmaskAttributes::VERSION
  
  gem.add_dependency 'activerecord', '~> 3.0'
end