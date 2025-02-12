# frozen_string_literal: true

module FileConverter
  # Interface for file converters
  class Converter
    def initialize(input_file, output_file)
      @input_file = input_file
      @output_file = output_file
      @file_object = load_file_object
    end

    def load_file_object
      raise NotImplementedError, "#{self.class} must implement load_file_object"
    end

    def convert(output_file)
      raise NotImplementedError, "#{self.class} must implement convert"
    end
  end
end
