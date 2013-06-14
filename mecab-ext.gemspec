# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mecab/ext/version'

Gem::Specification.new do |spec|
  spec.add_dependency "activesupport", ">= 3.2.13"

  spec.name          = "mecab-ext"
  spec.version       = Mecab::Ext::VERSION
  spec.authors       = ["Taiki ONO"]
  spec.email         = ["taiks.4559@gmail.com"]
  spec.description   = %q{Make mecab-ruby more handy for most of rubyist.}
  spec.summary       = %q{extensions for mecab-ruby}
  spec.homepage      = "https://github.com/taiki45/mecab-ext"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13.0"
  spec.add_development_dependency "simplecov", "~> 0.7.1"
  spec.add_development_dependency "coveralls", "~> 0.6.7"
end
