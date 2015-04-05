require "cwb"

class Sysbench < Cwb::Benchmark
  def cwb
    @cwb
  end
  
  def execute
    puts "execute sysbench in #{`pwd`}"
  end
  
  def cwb_metrics
    %w(cpu_model_name)
  end
end
