require "cwb"

class Sysbench < Cwb::Benchmark
  def cwb
    @cwb
  end

  def existing_attribute
    @cwb.deep_fetch("sysbench", "commands", "1")
  end

  def non_existing_attribute
    @cwb.deep_fetch("some", "non_existing", "attribute")
  end

  def execute
    puts "execute sysbench in #{`pwd`}"
  end
end
