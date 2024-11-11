module Soter
    class Railtie < Rails::Railtie
      # After gem is installed, automatically copy over the migrations
      initializer "soter.install_migrations" do |app|
        if app.config.respond_to?(:generators)
          app.config.generators do |g|
            g.orm :active_record, migration: true
          end
        end
  
        # Automatically invoke the migration generator (optional)
        if defined?(Rails::Generators)
          Rails::Generators.invoke("soter:migration")
        end
      end
    end
  end