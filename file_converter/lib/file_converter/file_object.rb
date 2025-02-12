# frozen_string_literal: true

module FileConverter
  # Abstract class to represent a file object
  class FileObject
    attr_reader :data

    def initialize(file_path, data = nil)
      @file_path = file_path
      @data = data || load_file
    end

    def load_file
      raise NotImplementedError, "#{self.class} must implement load_file"
    end

    def save(file_path)
      raise NotImplementedError, "#{self.class} must implement save"
    end
  end
end
