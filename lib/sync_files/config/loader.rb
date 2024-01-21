module SyncFiles
  CONFIG_FILENAMES = %w(
    config/sync_files.yml
    .sync_files.yml
  )

  module Config
    class Loader
      attr_reader :config

      def initialize
        @config = YAML.load(File.read(config_filename)) if config_filename
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
