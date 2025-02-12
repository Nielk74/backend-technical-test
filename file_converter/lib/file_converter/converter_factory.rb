# frozen_string_literal: true

module FileConverter
  # Factory class to get the correct converter
  class ConverterFactory
    CONVERTERS = {
      %w[json csv] => JsonToCsvConverter
    }.freeze

    def self.get_converter(input_file, output_file)
      input_format = File.extname(input_file).delete_prefix(".")
      ouput_format = File.extname(output_file).delete_prefix(".")
      key = [input_format.downcase, ouput_format.downcase]
      converter_class = CONVERTERS[key]
      raise FileConverter::UnsupportedConversionError, "Unsupported conversion: #{key}" unless converter_class

      converter_class.new(input_file, output_file)
    end
  end
end
