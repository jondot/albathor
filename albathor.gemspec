# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "albathor/version"

Gem::Specification.new do |s|
  s.name        = "albathor"
  s.version     = Albathor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dotan Nahum"]
  s.email       = ["jondotan@gmail.com"]
  s.homepage    = "http://blog.paracode.com"
  s.summary     = %q{A build generator for Albacore}
  s.description = %q{A build generator for Albacore}

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
