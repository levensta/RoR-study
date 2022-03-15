# frozen_string_literal: true

require_relative 'lib/deepthought/version'

Gem::Specification.new do |spec|
  spec.name = 'deepthought'
  spec.version = Deepthought::VERSION
  spec.authors = ['levensta']
  spec.email = ['levensta@student.21-school.ru']

  spec.summary = 'First gem named by deepthought'
  spec.description = 'This is the first gem that is created as part of the Ruby on Rails training'
  spec.homepage = 'https://github.com/levensta/RoR-study/'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    %w[bin/console bin/setup deepthought.gemspec Gemfile Gemfile.lock lib/deepthought/version.rb
       lib/deepthought.rb LICENSE.txt Rakefile README.md test/deepthought_test.rb test/test_helper.rb].reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'colorize', '~> 0.8.1'
  spec.add_dependency 'minitest', '~> 5.14.4'
  spec.add_dependency 'rake', '~> 13.0.3'
end
