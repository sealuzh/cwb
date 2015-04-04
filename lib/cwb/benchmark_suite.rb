require "active_support/core_ext/string/inflections"

module Cwb
  class BenchmarkSuite
    def initialize(path)
      @path = path
    end
    
    def execute
      if File.directory?(@path)
        handle_directory
      else
        handle_file
      end
    end
    
    def handle_directory
      check_benchmarks_file
      benchmarks = IO.readlines benchmarks_file_path
      benchmark_files = benchmark_files(benchmarks)
      require_all(benchmark_files)
      cwb_benchmarks = init_classes(benchmarks)
      cwb_benchmarks.each_with_index do |cwb_benchmark, index|
        execute_in_working_dir(cwb_benchmark, benchmark_files[index])
      end
    end
    
    def handle_file
      full_path = File.expand_path(@path)
      require_relative full_path

      filename = File.basename(@path, ".rb")
      clazz = filename.camelize.constantize
      cwb_benchmark = clazz.new
      execute_in_working_dir(cwb_benchmark, full_path)
    end

    private

    def execute_in_working_dir(cwb_benchmark, benchmark_file)
      parent_dir = File.dirname(benchmark_file)
      Dir.chdir parent_dir do
        cwb_benchmark.execute
      end
    end

    def init_classes(benchmarks)
      cwb_benchmarks = []
      benchmarks.each do |benchmark|
        cwb_benchmarks << benchmark_class(benchmark).new
      end
      cwb_benchmarks
    end

    def benchmark_class(benchmark)
      benchmark.underscore.strip.camelize.constantize
    end

    def benchmark_files(benchmarks)
      benchmark_files = []
      benchmarks.each do |benchmark|
        class_file = benchmark_file(benchmark.strip)
        check_benchmark_file_exists(class_file)
        benchmark_files << class_file
      end
      benchmark_files
    end

    def require_all(benchmark_files)
      benchmark_files.each do |benchmark_file|
        require_relative benchmark_file
      end
    end

    def check_benchmark_file_exists(class_file)
      unless File.exists?(class_file)
        fail "No benchmark class file found at: #{class_file}"
      end
    end

    def benchmark_file(benchmark)
      File.join(@path, benchmark, "#{benchmark.underscore}.rb")
    end

    def check_benchmarks_file
      unless File.exists?(benchmarks_file_path)
        fail "No benchmarks file found at: #{benchmarks_file_path}."
      end
    end

    def benchmarks_file_path
      File.join(@path, "benchmarks.txt")
    end

  end
end
