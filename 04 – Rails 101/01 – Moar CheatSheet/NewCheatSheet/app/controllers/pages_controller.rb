class PagesController < ApplicationController
    attr_reader :title
  
    def convention
      @title = "convention"
    end
  
    def console
      @title = "console"
    end
  
    def ruby
      @title = "ruby"
    end
  
    def ruby_concepts
      @title = "ruby-concepts"
    end
  
    def ruby_numbers
      @title = "ruby-numbers"
    end
  
    def ruby_strings
      @title = "ruby-strings"
    end
  
    def ruby_arrays
      @title = "ruby-arrays"
    end
  
    def ruby_hashes
      @title = "ruby-hashes"
    end
  
    def rails
        @tile ="rails"
    end
  
    def rails_folder_structure
      @title = "rails-folder-structure"
    end
  
    def rails_commands
      @title = "rails-commands"
    end
  
    def rails_erb
      @title = "rails-erb"
    end
  
    def editor
      @title = "editor"
    end
  
    def help
      @title = "help"
    end
end
