require "cwb"

class Sysbench < CwbBenchmark
  def cwb
    @cwb
  end
  
  def cwb_metrics
    %w(cpu_model_name)
  end
end
