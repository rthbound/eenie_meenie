# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "eenie_meenie/version"

Gem::Specification.new do |s|
  s.name        = "eenie_meenie"
  s.version     = EenieMeenie::VERSION
  s.authors     = ["Tad Hosford"]
  s.email       = ["tad.hosford@gmail.com"]
  s.homepage    = "http://github.com/rthbound/eenie_meenie"
  s.description = %q{ Attempts to provide a random but (mostly)
                      even distribution of samples amongst
                      specified groups
                    }
  s.summary     = %q{ }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency     "pay_dirt",     "~> 0.0.5"

  s.add_development_dependency "minitest"

  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
end
