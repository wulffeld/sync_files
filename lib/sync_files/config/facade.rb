module SyncFiles
  module Config
    class Facade
      def initialize
        load_config
      end

      def valid?
        SyncFiles::Config::Validation.new(config: @loader.config).valid?
      end

      def iterate
        @config["groups"].each do |group|
          group["fixtures"].each do |fixture|
            yield fixture["filename"], fixture["url"], group["settings"]["destination"]
          end
        end
      end

      private

      def load_config
        @loader = SyncFiles::Config::Loader.new
        @config = @loader.config
        @loader.has_config?
      end
    end
  end
end
