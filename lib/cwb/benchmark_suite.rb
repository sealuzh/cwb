module Cwb
  class BenchmarkSuite
    def initialize(working_dir = Dir.pwd)
      @cwb = Cwb::Client.instance
      @working_dir = working_dir
    end

    def execute_suite(cwb_benchmarks)
      execute_all(cwb_benchmarks)
      @cwb.notify_finished_execution
    rescue => error
      @cwb.notify_failed_execution(error.message)
      raise error
    end

    def execute_all(cwb_benchmarks)
      cwb_benchmarks.each do |cwb_benchmark|
        cwb_benchmark.execute_in_working_dir
      end
    end

    # Lookup the implementation of a certain benchmark
    def get(clazz, cwb_benchmarks)
      cwb_benchmarks.select{|cwb_benchmark| cwb_benchmark.instance_of?(clazz) }.first
    end

    def get_list(clazzes, cwb_benchmarks)
      list = []
      clazzes.each do |clazz|
        list << get(clazz, cwb_benchmarks)
      end
      list
    end
  end
end
