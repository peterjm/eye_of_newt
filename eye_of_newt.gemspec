# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eye_of_newt/version'

Gem::Specification.new do |spec|
  spec.name          = "eye-of-newt"
  spec.version       = EyeOfNewt::VERSION
  spec.authors       = ["Peter McCracken"]
  spec.email         = ["peter@petermccracken.com"]
  spec.summary       = %q{Natural language ingredient parser}
  spec.description   = %q{Parses natural ingredients (e.g. "1 1/2 pounds of potatoes, peeled") into usable parts.}
  spec.homepage      = "http://github.com/peterjm/eye_of_newt"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "racc", "~> 1"
  spec.add_development_dependency "pry", "~> 0"
  spec.add_development_dependency "pry-byebug", "~> 1"
  spec.add_development_dependency "pry-rescue", "~> 1"
end
