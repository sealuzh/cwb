require "thor"

require "active_support/core_ext/string/inflections"

module Cwb
  class Cli < Thor
    desc "execute BENCHMARK_FILE|BENCHMARK_DIRECTORY", "run a benchmark or an entire collection of benchmark in a given directory with cwb"
    def execute(path)
      filename = File.basename(path, ".rb")

      full_path = File.expand_path(path)
      parent_dir = File.dirname(full_path)

      require_relative full_path

      clazz = filename.camelize.constantize
      benchmark = clazz.new
      Dir.chdir parent_dir do
        benchmark.execute
      end
    end
  end
end
