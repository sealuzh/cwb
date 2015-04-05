module Cwb
  class Parser
    def initialize(path)
      @path = File.expand_path(path)
    end

    def validate
      fail "Not implemented in abstract base class"
    end

    def execute
      validate
      delegate_execution
    end

    def delegate_execution
      fail "Not implemented in abstract base class"
    end

    def benchmark_suite
      Cwb::BenchmarkSuite.new(@path)
    end

    private

    def check_file_exists(file)
      unless File.exists?(file)
        fail "No file found at: #{file}"
      end
    end
  end
end
