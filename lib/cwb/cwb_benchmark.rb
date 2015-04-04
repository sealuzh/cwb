require "cwb/client"

class CwbBenchmark
  def initialize
    @cwb = Cwb::Client.new
  end
end