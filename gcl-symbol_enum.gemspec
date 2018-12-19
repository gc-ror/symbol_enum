# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# noinspection RubyResolve
require 'gcl/symbol_enum/version'

Gem::Specification.new do |spec|
  spec.name = 'gcl-symbol_enum'
  spec.version = Gcl::SymbolEnum::VERSION
  spec.authors = %w[t-hane]
  spec.email = %w[t-hane@gc-story.com]

  spec.summary = 'Symbol enumerator'
  spec.description = 'Add C enum like syntax.'
  spec.homepage = 'https://github.com/gc-ror/gcl-symbol_enum.git'
  spec.license = 'MIT'

  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = ''
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = spec.homepage
  else
    raise 'RubyGems 2.0 or newer is required to protect' \
            ' against public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
end
