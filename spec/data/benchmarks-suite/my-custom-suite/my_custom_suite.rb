require "cwb"

class MyCustomSuite < Cwb::BenchmarkSuite
  def cwb
    @cwb
  end
  
  def execute_suite(cwb_benchmarks)
    my_list = get_list([Sysbench, MyCustomBenchmark], cwb_benchmarks)
    execute_all(my_list)
    @cwb.notify_finished_execution
    # @cwb.execute(Sysbench.new)
  end
end
