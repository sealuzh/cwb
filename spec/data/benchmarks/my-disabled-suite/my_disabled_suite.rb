require "cwb"

class MyDisabledSuite < Cwb::BenchmarkSuite
  def execute_suite(cwb_benchmarks)
    fail "Disabled suite should never be reached"
  end
  
  def cwb_metrics
    %w(metric_from_disabled_suite)
  end
end
