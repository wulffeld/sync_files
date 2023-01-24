require "rails_helper"

describe SyncFiles::Config::Loader do
  describe "#initialize" do
    it "initializes with a config file" do
      expect(YAML).to receive(:load).and_return(
        "settings" => {"destination" => "spec/fixtures"},
        "fixtures" => []
      )
      expect(File).to receive(:exist?).twice.and_return(true)
      expect(File).to receive(:read).and_return("")

      described_class.new
    end
  end
end
