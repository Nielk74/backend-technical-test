# frozen_string_literal: true

require_relative "../../lib/file_converter/file_objects/csv_file"

RSpec.describe FileConverter::CsvFile do
  describe "#flatten_hash" do
    let(:nested_json) do
      {
        "id" => 1,
        "user" => {
          "name" => "John",
          "profile" => {
            "age" => 30,
            "city" => "New York"
          }
        },
        "tags" => %w[ruby developer]
      }
    end

    it "flattens nested JSON correctly" do
      file = FileConverter::CsvFile.new(nil, [])
      result = file.send(:flatten_hash, nested_json)

      expect(result).to eq(
        {
          "id" => 1,
          "user.name" => "John",
          "user.profile.age" => 30,
          "user.profile.city" => "New York",
          "tags" => "ruby,developer"
        }
      )
    end
  end
end
