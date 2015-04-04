require "thor"
require "cwb/benchmark_suite"

module Cwb
  class Cli < Thor
    desc "execute BENCHMARK_FILE|BENCHMARK_DIRECTORY", "execute a benchmark or an entire collection of benchmark in a given directory with cwb"
    def execute(path)
      benchmark_suite = Cwb::BenchmarkSuite.new(path)
      benchmark_suite.execute
    rescue => error
      puts "Error: #{error.message}"
      raise error
    end
  end
end
