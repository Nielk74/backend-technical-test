# frozen_string_literal: true

require_relative 'file_converter/lib/file_converter'

if ARGV.size < 2 || ARGV.size > 3
  puts 'Usage: convert <input_folder> <output_folder> [output_format]'
  exit 1
end

input_folder, output_folder, output_format = ARGV
output_format ||= 'csv'

begin
  Dir.glob("#{input_folder}/*") do |file|
    input_file = file
    output_file = "#{output_folder}/#{File.basename(file, '.*')}.#{output_format}"
    converter = FileConverter::ConverterFactory.get_converter(input_file, output_file)
    converter.convert
  end
rescue StandardError => e
  puts "Error: #{e}"
end
