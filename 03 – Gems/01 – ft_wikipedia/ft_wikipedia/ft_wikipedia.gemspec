# frozen_string_literal: true

require_relative 'lib/ft_wikipedia/version'

Gem::Specification.new do |spec|
  spec.name = 'ft_wikipedia'
  spec.version = Ft_wikipedia::VERSION
  spec.authors = ['levensta']
  spec.email = ['levensta@student.21-school.ru']

  spec.summary = 'First gem named by ft_wikipedia'
  spec.description = 'This is the first gem that is created as part of the Ruby on Rails training'
  spec.homepage = 'https://github.com/levensta/RoR-study/'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    %w[bin/console bin/setup CHANGELOG.md ft_wikipedia.gemspec Gemfile Gemfile.lock
       lib/ft_wikipedia/version.rb lib/ft_wikipedia.rb LICENSE.txt Rakefile README.md test/ft_wikipedia_test.rb test/test_helper.rb].reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'minitest', '~> 5.14.4'
  spec.add_dependency 'nokogiri', '~> 1.11.6'
  spec.add_dependency 'rake', '~> 13.0.3'
end
