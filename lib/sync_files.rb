require_relative "sync_files/version"

require "rake"
require "httparty"

require "sync_files/config/facade"
require "sync_files/config/loader"
require "sync_files/config/parser"
require "sync_files/config/validation"
require "sync_files/fixtures/process"
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
        puts "Fetching fixtures: #{url} #{filename}"

        SyncFiles::Fixtures::Process.new(filename: filename, url: url, destination: destination).run
      end
    end
  end
end
