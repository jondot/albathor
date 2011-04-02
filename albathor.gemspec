# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "albathor/version"

Gem::Specification.new do |s|
  s.name        = "albathor"
  s.version     = Albathor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "albathor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "thor",   "~>0.14.0"
  s.add_dependency "nokogiri",   "~>1.4.4"
  s.add_dependency "rubyzip",   "~>0.9.4"
  s.add_development_dependency "riot", "~>0.12.2"
end
