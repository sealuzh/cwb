require "cwb/parser"

module Cwb
  class FileParser < Parser
    def delegate_execution
      filename = File.basename(@path, ".rb")
      class_name = filename.camelize
      cwb_benchmark = Cwb.const_get(class_name).new(File.dirname(@path))
      benchmark_suite.execute_suite([cwb_benchmark])
    end

    def validate
      check_file_exists(@path)
      require @path
    end
  end
end