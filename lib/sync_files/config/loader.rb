module SyncFiles
  CONFIG_FILENAMES = %w(
    config/sync_files.yml
    .sync_files.yml
  )

  module Config
    class Loader
      attr_reader :config

      def initialize
        if config_filename
          @config = YAML.load(File.read(config_filename))
        else
          puts "ERROR: No config file found. Please create one of the following files: #{CONFIG_FILENAMES.join(", ")}"
        end
      end

      def has_config?
        !@config.nil?
      end

      private

      def config_filename
        CONFIG_FILENAMES.each do |filename|
          filename = File.join(::Rails.root.to_s, filename)
          return filename if File.exist?(filename)
        end

        nil
      end
    end
  end
end
