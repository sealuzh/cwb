require "cwb/client"

module Cwb
  class Benchmark
    def initialize
      @cwb = Cwb::Client.new
    end
  end
end