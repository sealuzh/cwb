require "cwb"

class Disabled < Cwb::Benchmark
  def execute
    fail "Disabled benchmark should never be executed"
  end
end
