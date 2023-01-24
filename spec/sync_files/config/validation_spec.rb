require "rails_helper"

describe SyncFiles::Config::Validation do
  let(:settings_only_config_file) {
    {
      "settings" => {"destination" => "spec/fixtures"},
      "fixtures" => []
    }
  }

  def stub_valid_config_file
    expect(YAML).to receive(:load).and_return(
      "settings" => {"destination" => "spec/fixtures"},
      "fixtures" => [{ "filename" => "test.txt", "url" => "http://example.com/test.txt" }]
    )
  end

  def test_input(config)
    described_class.new(config: config).valid?
  end

  describe "#valid?" do
    context "with an empty config" do
      it "returns false" do
        expect(test_input({})).to be_falsey
      end
    end

    describe "#valid_config?" do
      context "when settings are missing" do
        it "returns false" do
          expect(test_input(settings_only_config_file)).to be_falsey
        end
      end

      context "when settings are correct" do
        it "returns true" do
          expect(test_input(settings_only_config_file)).to be_falsey
        end
      end
    end
  end
end
