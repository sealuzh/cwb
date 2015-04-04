require "cwb"

class Disabled < Cwb::Benchmark
  def cwb
    @cwb
  end
  
  def execute
    puts "execute disabled in #{`pwd`}"
    fail "Disabled benchmark should not execute"
  end
  
  def cwb_metrics
    %w()
  end
end
