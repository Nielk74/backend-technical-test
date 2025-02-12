# frozen_string_literal: true

require_relative "file_converter/file_objects/file_object"
require_relative "file_converter/file_objects/json_file"
require_relative "file_converter/file_objects/csv_file"
require_relative "file_converter/converters/converter"
require_relative "file_converter/converters/json_to_csv_converter"
require_relative "file_converter/converter_factory"

module FileConverter
  class Error < StandardError; end
  class InexistentFileError < Error; end
  class InvalidFileError < Error; end
  class UnsupportedConversionError < Error; end
end
