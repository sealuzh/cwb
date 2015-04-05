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
      require_all(benchmarks)
      cwb_benchmarks = init_classes(benchmarks)
      cwb_benchmarks.each do |cwb_benchmark|
        cwb_benchmark.execute_in_working_dir
      end
    end
    
    def handle_file
      full_path = File.expand_path(@path)
      require_relative full_path

      filename = File.basename(@path, ".rb")
      clazz = filename.camelize.constantize
      cwb_benchmark = clazz.new(File.dirname(full_path))
      cwb_benchmark.execute_in_working_dir
    end

    private

    def init_classes(benchmarks)
      cwb_benchmarks = []
      benchmarks.each do |benchmark|
        stripped_benchmark = benchmark.strip
        cwb_benchmarks << benchmark_class(stripped_benchmark).new(working_dir(stripped_benchmark))
      end
      cwb_benchmarks
    end

    def working_dir(benchmark)
      File.join(@path, benchmark)
    end

    def benchmark_class(benchmark)
      benchmark.underscore.camelize.constantize
    end

    def require_all(benchmarks)
      benchmarks.each do |benchmark|
        class_file = benchmark_file(benchmark.strip)
        check_benchmark_file_exists(class_file)
        require_relative class_file
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
