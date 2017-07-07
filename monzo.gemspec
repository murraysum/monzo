# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "monzo/version"

Gem::Specification.new do |spec|
  spec.name          = "monzo"
  spec.version       = Monzo::VERSION
  spec.authors       = ["Murray Summers"]
  spec.email         = ["murray.sum@gmail.com"]

  spec.summary       = "A simple interface to make requests to the Monzo API"
  spec.homepage      = "https://github.com/murraysum/monzo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.0"
  spec.add_development_dependency "factory_girl", "4.7.0"
  spec.add_development_dependency "byebug", "~> 9.0"
end
