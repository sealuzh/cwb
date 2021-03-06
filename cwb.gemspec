# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cwb/version"

Gem::Specification.new do |spec|
  spec.name          = "cwb"
  spec.version       = Cwb::VERSION
  spec.executables   << 'cwb'
  spec.authors       = ["Joel Scheuner"]
  spec.email         = ["joel.scheuner.dev@gmail.com"]
  spec.summary       = %q{Provides Cloud WorkBench (CWB) infrastructure for cloud VMs and local testing.}
  spec.homepage      = "https://github.com/sealuzh/cloud-workbench"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.19"
  spec.add_runtime_dependency "faraday", "~> 0.9.1"
  spec.add_runtime_dependency "faraday_middleware", "~> 0.9.1"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "simplecov", "~> 0.9"
  spec.add_development_dependency "guard-rspec", "~> 4.5"
end
