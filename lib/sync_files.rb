require_relative "sync_files/version"

require "rake"
require "httparty"

require "sync_files/config/facade"
require "sync_files/config/loader"
require "sync_files/config/parser"
require "sync_files/config/validation"
require "sync_files/engine"

module SyncFiles
  class Sync
    def initialize
      @facade = Config::Facade.new
    end

    def run
      return unless @facade.valid?

      process_fixtures
    end

    private

    def process_fixtures
      @facade.iterate do |filename, url, destination|
        puts "Getting fixtures: #{url} #{filename}"

        response = HTTParty.get(url)
        if response.code != 200
          puts "ERROR: #{response.code} #{response.message} for #{url}"
          next
        end

        open(File.join(::Rails.root.to_s, destination, filename), "wb") do |file|
          file << response.body
        end
      end
    end
  end
end
