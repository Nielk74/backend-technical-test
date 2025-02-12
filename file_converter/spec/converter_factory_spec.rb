# frozen_string_literal: true

require_relative "../lib/file_converter/converter_factory"
require_relative "../lib/file_converter/converters/json_to_csv_converter"

RSpec.describe FileConverter::ConverterFactory do
  describe ".get_converter" do
    let(:json_file) { "test.json" }
    let(:csv_file) { "output.csv" }
    let(:valid_json) do
      '[{"id":1,"name":"Alice"},{"id":2,"name":"Bob"}]'
    end

    before do
      File.write(json_file, valid_json) # Create a valid JSON file
    end

    after do
      File.delete(json_file) if File.exist?(json_file)
      File.delete(csv_file) if File.exist?(csv_file)
    end

    context "when a valid conversion is requested" do
      it "returns the correct converter for json to csv" do
        converter = FileConverter::ConverterFactory.get_converter(json_file, csv_file)
        expect(converter).to be_a(FileConverter::JsonToCsvConverter)
      end
    end

    context "when an unsupported conversion is requested" do
      it "raises an error" do
        expect do
          FileConverter::ConverterFactory.get_converter("test.xml", "output.csv")
        end.to raise_error(FileConverter::UnsupportedConversionError)
      end
    end

    context "when an input file does not exist" do
      it "raises a file not found error" do
        expect do
          FileConverter::ConverterFactory.get_converter("non_existent.json", "non_existent.csv")
        end.to raise_error(Errno::ENOENT)
      end
    end
  end
end
