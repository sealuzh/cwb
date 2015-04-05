require "cwb/file_parser"
require "cwb/directory_parser"
require "cwb/directory_suite_parser"

module Cwb
  module ParserFactory
    def self.build(path)
      if File.directory?(path) && Cwb::DirectorySuiteParser.suite_file_present?(path)
        Cwb::DirectorySuiteParser.new(path)
      elsif File.directory?(path)
        Cwb::DirectoryParser.new(path)
      else
        Cwb::FileParser.new(path)
      end
    end
  end
end
