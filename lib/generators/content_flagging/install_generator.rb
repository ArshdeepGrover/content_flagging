require 'rails/generators'
require 'rails/generators/migration'

module ContentFlagging
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path('templates', __dir__)
      
      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
      
      def create_migration
        migration_template 'create_content_flags.rb.erb', 'db/migrate/create_content_flags.rb'
      end
      
      def create_initializer
        template 'content_flagging.rb', 'config/initializers/content_flagging.rb'
      end
    end
  end
end