# frozen_string_literal: true

require_relative "converter"
require_relative "../file_objects/json_file"
require_relative "../file_objects/csv_file"

module FileConverter
  # Class to convert a JSON file to a CSV file
  class JsonToCsvConverter < Converter
    def load_file_object
      JsonFile.new(@input_file)
    end

    def convert
      raise "Invalid JSON format. Must be an array of objects." unless @file_object.data.is_a?(Array)

      csv_file = CsvFile.from_data(@file_object.data)
      csv_file.save(@output_file)
      puts "Converted JSON to CSV: #{@output_file}"
    end
  end
end
