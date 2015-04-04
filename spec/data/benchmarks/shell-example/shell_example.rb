require "cwb"

class ShellExample < Cwb::Benchmark
  def cwb
    @cwb
  end
  
  def execute
    puts "execute shell-example in #{`pwd`}"
  end
  
  def cwb_metrics
    %w(cpu_model_name)
  end
end
