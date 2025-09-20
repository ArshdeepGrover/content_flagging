require_relative 'lib/content_flagging/version'

Gem::Specification.new do |spec|
  spec.name          = 'content_flagging'
  spec.version       = ContentFlagging::VERSION
  spec.authors       = ['Arshdeep Singh']
  spec.email         = ['arsh199820@gmail.com']
  spec.summary       = 'The acts_as_paranoid for content moderation - automatic flagging system for Rails'
  spec.description   = 'A powerful Rails gem that automatically hides inappropriate content when flagged. Like acts_as_paranoid for deleted records, acts_as_flaggable hides flagged content from default scopes with configurable thresholds.'
  spec.homepage      = 'https://github.com/arshdeepsingh/content_flagging'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'
  
  spec.metadata = {
    'homepage_uri' => 'https://github.com/arshdeepsingh/content_flagging',
    'source_code_uri' => 'https://github.com/arshdeepsingh/content_flagging',
    'changelog_uri' => 'https://github.com/arshdeepsingh/content_flagging/blob/main/CHANGELOG.md',
    'bug_tracker_uri' => 'https://github.com/arshdeepsingh/content_flagging/issues',
    'documentation_uri' => 'https://github.com/arshdeepsingh/content_flagging/blob/main/README.md',
    'rubygems_mfa_required' => 'true'
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