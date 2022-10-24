lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/installonair/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-installonair'
  spec.version       = Fastlane::Installonair::VERSION
  spec.author        = %q{SpQuyt}
  spec.email         = %q{spquyt@gmail.com}

  spec.summary       = 'Install On Air plugin integrated with Fastlane'
  spec.homepage      = "https://github.com/SpQuyt/fastlane-plugin-installonair.git"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_dependency 'rest-client', '>= 2.0.0'
  spec.add_dependency 'tty-spinner', '>= 0.9.0'
  spec.add_development_dependency('bundler')
  spec.add_development_dependency('fastlane', '>= 2.209.0')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rubocop', '1.12.1')
  spec.add_development_dependency('rubocop-performance')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
end
