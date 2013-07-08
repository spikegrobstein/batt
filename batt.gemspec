# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'batt/version'

Gem::Specification.new do |spec|
  spec.name          = "batt"
  spec.version       = Batt::VERSION
  spec.authors       = ["Spike Grobstein"]
  spec.email         = ["me@spike.cx"]
  spec.description   = %q{Read basic information about your laptop's battery. Includes both ANSI and tmux colour support.}
  spec.summary       = %q{Read basic information about your laptop's battery}
  spec.homepage      = "https://github.com/spikegrobstein/batt"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "cocaine", "~> 0.5"
  spec.add_dependency "thor"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
