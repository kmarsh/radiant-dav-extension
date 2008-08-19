namespace :radiant do
  namespace :extensions do
    namespace :radiant_dav do
      
      desc "Runs the migration of the Radiant Dav extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          RadiantDavExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          RadiantDavExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Radiant Dav to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[RadiantDavExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(RadiantDavExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
