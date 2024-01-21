require "rails_helper"

describe SyncFiles::Config::Facade do
  let(:valid_config_file) {
    {
      "groups" => [
        "settings" => {"destination" => "spec/fixtures"},
        "fixtures" => [{ "filename" => "example.html", "url" => "http://example.com/" }]
      ]
    }
  }

  describe "#iterate" do
    it "yields fixture data" do
      expect(SyncFiles::Config::Loader).to receive(:new).and_return(double(config: valid_config_file, has_config?: true))

      expect { |b| described_class.new.iterate(&b) }.to yield_with_args("example.html", "http://example.com/", "spec/fixtures")
    end
  end

  describe "#valid?" do
    it "returns true if the config file is valid" do
      expect(SyncFiles::Config::Loader).to receive(:new).and_return(double(config: valid_config_file, has_config?: true))

      expect(described_class.new.valid?).to eq(true)
    end

    it "returns false if the config file is invalid" do
      expect(SyncFiles::Config::Loader).to receive(:new).and_return(double(config: nil, has_config?: false))

      expect(described_class.new.valid?).to eq(false)
    end
  end
end
