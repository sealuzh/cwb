require "cwb/client"

module Cwb
  class Benchmark
    def initialize(working_dir = Dir.pwd)
      @working_dir = working_dir
      @cwb = Cwb::Client.new
    end

    def execute_in_working_dir
      Dir.chdir @working_dir do
        execute
      end
    end

    # Intended to override
    def execute
      
    end
  end
end