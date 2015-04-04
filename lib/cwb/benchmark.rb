require "cwb/client"

module Cwb
  class Benchmark
    def initialize
      @cwb = Cwb::Client.new
    end

    def pre_execute_suite
      
    end

    # Benchmark suites may overwrite this method if they want to provide their own lifecycle management (i.e., communication with the cwb-server)
    def execute_suite
      
    end

    # Intended to override
    def execute
      
    end
  end
end