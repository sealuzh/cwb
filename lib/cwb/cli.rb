require "thor"
require "cwb/parser_factory"
require "cwb/version"

module Cwb
  class Cli < Thor
    map %w[--version -v] => :__print_version

    desc "--version, -v", "print the version"
    def __print_version
      puts Cwb::VERSION
    end

    desc "execute BENCHMARK_FILE|BENCHMARK_DIRECTORY", "execute a benchmark or an entire collection of benchmark in a given directory with cwb"
    option :aliases => :e
    def execute(path)
      Cwb::ParserFactory.build(path).execute
    end
    
    desc "validate BENCHMARK_FILE|BENCHMARK_DIRECTORY", "performs basic validation of the class files and directory structure."
    option :aliases => :v
    def validate(path)
      Cwb::ParserFactory.build(path).validate
    end
  end
end
