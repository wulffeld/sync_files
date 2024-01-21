module SyncFiles
  module Config
    class Validation
      class Invalid < Exception; end

      def initialize(config:)
        @config = config
      end

      def valid?
        validate!
        true
      rescue SyncFiles::Config::Validation::Invalid => e
        puts e.message
        false
      end

      def validate!
        raise Invalid.new("ERROR: No config file found. Please create one of the following files: #{CONFIG_FILENAMES.join(", ")}") unless @config
        raise Invalid.new("ERROR: No groups specified in the config file.") unless validate_groups
        raise Invalid.new("ERROR: No files specified in the config file.") unless validate_fixtures
        raise Invalid.new("ERROR: No destination specified in the config file.") unless validate_settings
      end

      def validate_settings
        groups.all? { |group| !group["settings"].nil? && !group["settings"]["destination"].nil? }
      end

      def validate_fixtures
        groups.all? { |group| !group["fixtures"].nil? && !group["fixtures"].empty? }
      end

      def validate_groups
        !(@config["groups"].nil?)
      end

      def groups
        @config["groups"]
      end
    end
  end
end
