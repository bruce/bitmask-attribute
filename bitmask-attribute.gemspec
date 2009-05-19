# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bitmask-attribute}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bruce Williams"]
  s.date = %q{2009-05-18}
  s.email = %q{bruce@codefluency.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.markdown"
  ]
  s.files = [
    "LICENSE",
    "README.markdown",
    "Rakefile",
    "VERSION.yml",
    "lib/bitmask-attribute.rb",
    "lib/bitmask_attribute.rb",
    "lib/bitmask_attribute/value_proxy.rb",
    "rails/init.rb",
    "test/bitmask_attribute_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bruce/bitmask-attribute}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Simple bitmask attribute support for ActiveRecord}
  s.test_files = [
    "test/bitmask_attribute_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
  end
end
