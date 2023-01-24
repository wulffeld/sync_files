module SyncFiles
  CONFIG_FILES = %w(
    config/sync_files.yml
    .sync_files.yml
  )

  module Config
    class Parser
      attr_reader :config

      def initialize(config:)
        @config = config
        parse
      end

      private

      def parse
      end
    end
  end
end
