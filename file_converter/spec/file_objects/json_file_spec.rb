# frozen_string_literal: true

require "json"
require "fileutils"
require_relative "../../lib/file_converter/file_objects/json_file"

RSpec.describe FileConverter::JsonFile do
  let(:valid_json) { '{"id": 1, "name": "John"}' }
  let(:invalid_json) { '{id: 1, name: "John"' }
  let(:json_file) { "test.json" }

  before do
    File.write(json_file, valid_json)
  end

  after do
    FileUtils.rm_f(json_file)
  end

  describe "#load_file" do
    it "parses valid JSON correctly" do
      file = FileConverter::JsonFile.new(json_file)
      expect(file.data).to eq({ "id" => 1, "name" => "John" })
    end

    it "raises an error for malformed JSON" do
      File.write(json_file, invalid_json)
      expect { FileConverter::JsonFile.new(json_file) }.to raise_error(FileConverter::Error)
    end
  end

  describe "#save" do
    it "writes JSON data to file" do
      file = FileConverter::JsonFile.new(json_file)
      file.save("output.json")
      saved_data = JSON.parse(File.read("output.json"))
      expect(saved_data).to eq({ "id" => 1, "name" => "John" })
      FileUtils.rm_f("output.json")
    end
  end
end
