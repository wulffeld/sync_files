module SyncFiles
  module Fixtures
    class Process
      attr_reader :filename, :url, :destination

      def initialize(filename:, url:, destination:)
        @filename = filename
        @url = url
        @destination = destination
      end

      def run
        response = HTTParty.get(url)
        if response.code != 200
          puts "ERROR: #{response.code} #{response.message} for #{url}"
          return
        end

        FileUtils.mkdir_p(write_path)

        open(write_filename, "wb") do |file|
          file << response.body
        end
      end

      private

      def write_filename
        File.join(::Rails.root.to_s, destination, filename)
      end

      def write_path
        File.dirname(write_filename)
      end
    end
  end
end
