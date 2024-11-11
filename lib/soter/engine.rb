module Soter
    class Engine < ::Rails::Engine
      # Specify that this is a Rails Engine
      isolate_namespace Soter
  
      # Ensure the engine loads its initializers, migrations, etc.
      initializer "soter.load_migrations" do |app|
        # This tells Rails to copy the migrations from the gem into the host app
        app.config.paths['db/migrate'] += Dir["#{config.root}/db/migrate"].each { |p| p.sub!(/^#{config.root}/, '') }
      end
    end
  end