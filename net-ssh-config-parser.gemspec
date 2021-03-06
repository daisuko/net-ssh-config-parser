# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'net/ssh/config/parser/version'

Gem::Specification.new do |spec|
  spec.name          = "net-ssh-config-parser"
  spec.version       = Net::SSH::Config::Parser::VERSION
  spec.authors       = ["daisuko"]
  spec.email         = ["striker.daisuko@gmail.com"]

  spec.summary       = 'a ssh config parser.'
  spec.homepage      = 'https://github.com/daisuko/net-ssh-config-parser'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
                         f.match(%r{^(test|spec|features)/})
                       end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'net-ssh'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
