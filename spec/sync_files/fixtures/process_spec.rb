require "rails_helper"

describe SyncFiles::Fixtures::Process do
  describe "#initialize" do
    it "sets the filename, url, and destination" do
      process = SyncFiles::Fixtures::Process.new(filename: "filename", url: "url", destination: "destination")

      expect(process.filename).to eq("filename")
      expect(process.url).to eq("url")
      expect(process.destination).to eq("destination")
    end
  end

  describe "#run" do
    let(:process) { SyncFiles::Fixtures::Process.new(filename: "filename", url: "url", destination: "destination") }
    let(:response) { double(code: 200, message: "OK", body: "body") }

    subject { process.run }

    before do
      allow(HTTParty).to receive(:get).with("url").and_return(response)
      allow(FileUtils).to receive(:mkdir_p)
      allow(process).to receive(:open)
    end

    it "fetches the fixture" do
      expect(HTTParty).to receive(:get).with("url").and_return(response)

      subject
    end

    it "creates the destination directory" do
      expect(FileUtils).to receive(:mkdir_p).with(File.join(::Rails.root.to_s, "destination"))

      subject
    end

    it "writes the fixture" do
      expect(process).to receive(:open).with(File.join(::Rails.root.to_s, "destination", "filename"), "wb")

      subject
    end
  end
end
