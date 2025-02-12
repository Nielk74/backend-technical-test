# frozen_string_literal: true

require "json"
require_relative "file_object"

module FileConverter
  # Class to represent a JSON file
  class JsonFile < FileObject
    def load_file
      JSON.parse(File.read(@file_path))
    rescue JSON::ParserError
      raise FileConverter::InvalidFileError, "Invalid JSON format in file: #{@file_path}"
    end

    def save(file_path)
      File.write(file_path, @data.to_json)
    end
  end
end
