# Results

[![Lint Status](https://github.com/Nielk74/backend-technical-test/actions/workflows/main.yml/badge.svg?branch=master)](https://github.com/Nielk74/backend-technical-test/actions/workflows/main.yml)

## Architecture

I opted for a modular approach to make this converter as extensible as possible and thus support other file types in the future.
On one side we have the file objects (FileObject) to represent files as objects and on the other side the converters (Converter) to convert files from one format to another.

```
.
└── file_converter
    ├── converter_factory.rb
    ├── converters
    │   ├── converter.rb
    │   └── json_to_csv_converter.rb
    └─  file_objects
        ├── csv_file.rb
        ├── file_object.rb
        └── json_file.rb
```

## Tests (RSpec)

I wrote unit tests for the `JsonFile`, `CsvFile` classes to make sure that the files are read and written correctly.
I also wrote integration tests for the `JsonToCsvConverter` and `ConverterFactory` classes to make sure that the files are converted from one format to another.

These tests are available in the `spec` folder.

# Json2Csv

This repository is part of: [MyJobGlasses](https://www.myjobglasses.com/) - Technical Test

The goal of this test is to write a small Ruby lib aiming to convert JSON files composed of arrays of objects (all following the same schema) to a flat CSV file where one line equals one object.

## Test instructions

Here is the input schema (GraphQL-like) of what our app is expected to process correctly

```
type Profile {
  id: String!
  email: String!
  tags: [String]
  profiles: [SocialProfile]
}

type SocialProfile {
  id: String!
  picture: String
}

```

Some sample files are located in `./input_json_files` and  `./output_csv_files`, they are user provided files from the internet

You can start by writing a `main.rb` (feel free to change this name) that will perform the conversion when running `ruby main.rb [input_dir] [output_dir]` of all the files of the input directory into the output dir

## Test rating criteria

- clean
- extensible
- robust (don't overlook edge cases, use exceptions where needed, ...)
- tested

You have no limitation of time, what we expect is to have a discussion about your choices and your code implementation.

To share your code, it's your choice again: send us a zip or a GitHub link!

Good luck!
