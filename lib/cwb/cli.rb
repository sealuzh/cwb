require "thor"
require "cwb/parser_factory"

module Cwb
  class Cli < Thor
    desc "execute BENCHMARK_FILE|BENCHMARK_DIRECTORY", "execute a benchmark or an entire collection of benchmark in a given directory with cwb"
    option :aliases => :e
    def execute(path)
      Cwb::ParserFactory.build(path).execute
    end
    
    desc "validates BENCHMARK_FILE|BENCHMARK_DIRECTORY", "performs basic validation of the class files and directory structure."
    option :aliases => :v
    def validate(path)
      Cwb::ParserFactory.build(path).validate
    end
  end
end
