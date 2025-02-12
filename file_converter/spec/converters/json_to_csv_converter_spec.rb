# frozen_string_literal: true

require "fileutils"
require_relative "../../lib/file_converter/converters/json_to_csv_converter"

RSpec.describe FileConverter::JsonToCsvConverter do
  let(:json_file) { "test.json" }
  let(:csv_file) { "test.csv" }
  let(:valid_json) do
    [
      { "id" => 1, "name" => "Alice", "tags" => %w[dev ruby] },
      { "id" => 2, "name" => "Bob", "tags" => ["python"] }
    ].to_json
  end

  before do
    File.write(json_file, valid_json)
  end

  after do
    FileUtils.rm_f(json_file)
    FileUtils.rm_f(csv_file)
  end

  it "converts JSON to CSV correctly" do
    converter = FileConverter::JsonToCsvConverter.new(json_file, csv_file)
    converter.convert

    saved_content = File.read(csv_file)
    expect(saved_content).to include("id,name,tags")
    expect(saved_content).to include("1,Alice,\"dev,ruby\"")
    expect(saved_content).to include("2,Bob,python")
  end
end
