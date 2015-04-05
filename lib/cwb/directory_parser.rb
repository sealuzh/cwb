require "cwb/parser"
require "cwb/benchmark_suite"

module Cwb
  class DirectoryParser < Parser
    def validate
      check_file_exists(benchmarks_file_path)
      require_all(read_lines(benchmarks_file_path))
    end

    def delegate_execution
      cwb_benchmarks = init_classes(read_lines(benchmarks_file_path))
      benchmark_suite.execute_suite(cwb_benchmarks)
    end

    private

      def read_lines(file)
        benchmarks = []
        File.readlines(file).each do |line|
          stripped = line.strip
          benchmarks << stripped unless stripped.empty?
        end
        benchmarks
      end

      def init_classes(benchmarks)
        cwb_benchmarks = []
        benchmarks.each do |benchmark|
          stripped_benchmark = benchmark
          cwb_benchmarks << Cwb.const_get(benchmark_class_name(stripped_benchmark)).new(working_dir(stripped_benchmark))
        end
        cwb_benchmarks
      end

      def working_dir(benchmark)
        File.join(@path, benchmark)
      end

      def benchmark_class_name(benchmark)
        benchmark.underscore.camelize
      end

      def require_all(benchmarks)
        benchmarks.each do |benchmark|
          class_file = benchmark_file(benchmark)
          check_file_exists(class_file)
          require class_file
        end
      end

      def benchmark_file(benchmark)
        File.join(@path, benchmark, "#{benchmark.underscore}.rb")
      end

      def benchmarks_file_path
        File.join(@path, "benchmarks.txt")
      end
  end
end