require "thor"
require "cwb/parser_factory"

module Cwb
  class Cli < Thor
    desc "execute BENCHMARK_FILE|BENCHMARK_DIRECTORY", "execute a benchmark or an entire collection of benchmark in a given directory with cwb"
    option :aliases => :e
    def execute(path)
      Cwb::ParserFactory.build(path).execute
    rescue => error
      puts "Error: #{error.message}"
      raise error
    end
    
    desc "validates BENCHMARK_FILE|BENCHMARK_DIRECTORY", "performs basic validation of the class files and directory structure."
    option :aliases => :v
    def validate(path)
      Cwb::ParserFactory.build(path).validate
    rescue => error
      puts "Error: #{error.message}"
      raise error
    end
  end
end
