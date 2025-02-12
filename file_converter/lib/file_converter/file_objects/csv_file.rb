# frozen_string_literal: true

require "csv"
require_relative "file_object"

module FileConverter
  # Class to represent a JSON file
  class CsvFile < FileObject
    def load_file
      csv_data = CSV.read(@file_path, headers: true, quote_char: '"', liberal_parsing: true)
      csv_data.map(&:to_h)
    rescue CSV::MalformedCSVError => e
      raise "CSV Parsing Error: #{e.message}"
    end

    def save(file_path)
      flattened_data = @data.map { |row| flatten_hash(row) }

      headers = flattened_data.flat_map(&:keys).uniq

      CSV.open(file_path, "w", quote_char: '"') do |csv|
        csv << headers
        flattened_data.each { |row| csv << headers.map { |h| row[h] } }
      end
    end

    def self.from_data(data)
      new(nil, data)
    end

    def flatten_hash(hash, parent_key = "", result = {})
      hash.each do |key, value|
        new_key = parent_key.empty? ? key : "#{parent_key}.#{key}"
        process_value(value, new_key, result)
      end
      result
    end

    private

    def process_value(value, new_key, result)
      if value.is_a?(Hash)
        flatten_hash(value, new_key, result)
      elsif value.is_a?(Array)
        result[new_key] = value.join(",")
      else
        result[new_key] = value
      end
    end
  end
end
