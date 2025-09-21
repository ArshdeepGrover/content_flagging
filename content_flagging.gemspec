require_relative 'lib/content_flagging/version'

Gem::Specification.new do |spec|
  spec.name          = 'content_flagging'
  spec.version       = ContentFlagging::VERSION
  spec.authors       = ['Arshdeep Singh']
  spec.email         = ['arsh199820@gmail.com']
  spec.summary       = 'Community-driven content moderation for Rails applications'
  spec.description   = <<~DESC
    ContentFlagging provides automatic content moderation for Rails applications through community flagging.
    When content receives too many flags, it's automatically hidden from default scopes - just like acts_as_paranoid
    for deleted records. Features configurable thresholds, thread-safe counters, polymorphic flagging, and
    comprehensive admin tools. Perfect for user-generated content platforms.
  DESC
  spec.homepage      = 'https://content-flagging.netlify.app'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'
  
  spec.metadata = {
    'homepage_uri' => 'https://content-flagging.netlify.app',
    'source_code_uri' => 'https://github.com/ArshdeepGrover/content_flagging',
    'changelog_uri' => 'https://github.com/ArshdeepGrover/content_flagging/blob/main/CHANGELOG.md',
    'bug_tracker_uri' => 'https://github.com/ArshdeepGrover/content_flagging/issues',
    'documentation_uri' => 'https://content-flagging.netlify.app',
    'wiki_uri' => 'https://github.com/ArshdeepGrover/content_flagging/wiki',
    'funding_uri' => 'https://github.com/sponsors/ArshdeepGrover',
    'rubygems_mfa_required' => 'true',
    'allowed_push_host' => 'https://rubygems.org'
  }
  
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  
  # Runtime dependencies
  spec.add_dependency 'activerecord', '>= 6.0'
  spec.add_dependency 'activesupport', '>= 6.0'
  spec.add_dependency 'railties', '>= 6.0'
  
  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-rails', '~> 5.0'
  spec.add_development_dependency 'sqlite3', '~> 1.4'
  spec.add_development_dependency 'pg', '~> 1.0'
  spec.add_development_dependency 'mysql2', '~> 0.5'
  spec.add_development_dependency 'rails', '>= 6.0'
  spec.add_development_dependency 'factory_bot_rails', '~> 6.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_development_dependency 'rubocop-rails', '~> 2.0'
  spec.add_development_dependency 'simplecov', '~> 0.21'
end