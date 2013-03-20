# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tophold_rack/version'

Gem::Specification.new do |gem|
  gem.name          = "tophold_rack"
  gem.version       = TopholdRack::VERSION
  gem.authors       = ["tteng"]
  gem.email         = ["tim.rubist@gmail.com"]
  gem.description   = %q{A rack based middleware to redispatch requested uri path to 3rd party tracking server}
  gem.summary       = %q{A rack based middleware to redispatch requested uri path to 3rd party tracking server}
  gem.homepage      = "http://github.com/tteng"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
