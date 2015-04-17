require "cwb"

class ShellExample < Cwb::Benchmark
  def cwb
    @cwb
  end
  
  def execute
    puts "execute shell-example in #{`pwd`}"
  end
end
