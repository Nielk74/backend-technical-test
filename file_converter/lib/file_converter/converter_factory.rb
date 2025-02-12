# frozen_string_literal: true

module FileConverter
  # Factory class to get the correct converter
  class ConverterFactory
    CONVERTERS = {
      %w[json csv] => JsonToCsvConverter
    }.freeze

    def self.get_converter(input_format, ouput_format, input_file)
      key = [input_format.downcase, ouput_format.downcase]
      converter_class = CONVERTERS[key]
      raise "Unsupported conversion: #{key}" unless converter_class

      converter_class.new(input_file)
    end
  end
end
