require "cwb"

class MyCustomBenchmark < Cwb::Benchmark
  def cwb
    @cwb
  end
  
  def execute
    puts "execute my-custom-benchmark in #{`pwd`}"
  end
  
  def cwb_metrics
    %w(cpu_model_name)
  end
end
