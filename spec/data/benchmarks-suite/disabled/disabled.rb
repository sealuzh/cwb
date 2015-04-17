require "cwb"

class MyCustomBenchmark < Cwb::Benchmark
  def execute
    fail "Disabled benchmark should never be executed"
  end
end
