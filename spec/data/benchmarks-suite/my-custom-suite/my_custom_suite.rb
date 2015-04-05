require "cwb"

class MyCustomSuite < Cwb::BenchmarkSuite
  def cwb
    @cwb
  end
  
  def execute_suite(cwb_benchmarks)
    my_list = get_list([Sysbench, MyCustomBenchmark], cwb_benchmarks)
    my_list.each do |cwb_benchmark|
      cwb_benchmark.execute_in_working_dir
    end
  end
  
  def cwb_metrics
    %w()
  end
end
