# frozen_string_literal: true

require_relative "file_object"

module FileConverter
  # Class to represent a JSON file
  class JsonFile < FileObject
    def load_file
      csv_data = CSV.read(@file_path)
      csv_data.map(&:to_h)
    end

    def save(file_path)
      headers = @data.first.keys || []
      CSV.open(file_path, "wb") do |csv|
        csv << headers
        @data.each do |row|
          csv << row.values
        end
      end
    end
  end
end
