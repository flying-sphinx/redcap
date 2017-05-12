# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'redcap/version'

Gem::Specification.new do |s|
  s.name        = 'redcap'
  s.version     = Redcap::Version
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Pat Allan']
  s.email       = ['pat@freelancing-gods.com']
  s.homepage    = 'http://github.com/flying-sphinx/redcap'
  s.summary     = %q{Translates SSH forward ports to process IDs}
  s.description = %q{A service that translates SSH forward ports to process IDs. Built for Flying Sphinx.}

  s.rubyforge_project = 'redcap'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f|
    File.basename(f)
  }
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
