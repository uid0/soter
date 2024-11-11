module Soter
    module Generators
      class MigrationGenerator < Rails::Generators::Base
        # The directory where migration files will be stored
        source_root File.expand_path('templates', __dir__)
  
        def create_migration_file
          # Create the migration file for AccessAudit
          migration_template "create_access_audits.rb", "db/migrate/create_access_audits.rb"
        end
      end
    end
  end