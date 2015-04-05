require "cwb"

class MyCustomBenchmark < Cwb::Benchmark
  def execute
    fail "Disabled benchmark should never be executed"
  end
  
  def cwb_metrics
    %w(metric_from_disabled_benchmark)
  end
end
