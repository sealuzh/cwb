require "cwb"

class MyDisabledSuite < Cwb::BenchmarkSuite
  def execute_suite(cwb_benchmarks)
    fail "Disabled suite should never be reached"
  end
end
