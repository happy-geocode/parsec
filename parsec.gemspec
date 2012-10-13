# -*- encoding: utf-8 -*-
require File.expand_path('../lib/parsec/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["moonglum"]
  gem.email         = ["moonglum@moonbeamlabs.com"]
  gem.description   = %q{Parsec is a natural language parser for addresses. It returns it to you in a simple format.}
  gem.summary       = %q{Parsec is a natural language parser for addresses. It returns it to you in a simple format.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "parsec"
  gem.require_paths = ["lib"]
  gem.version       = Parsec::VERSION
end
