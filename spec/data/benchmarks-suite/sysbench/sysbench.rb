require "cwb"

class Sysbench < Cwb::Benchmark
  def cwb
    @cwb
  end
  
  def execute
    puts "execute sysbench in #{`pwd`}"
  end
end
