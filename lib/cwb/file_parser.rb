require "cwb/parser"

module Cwb
  class FileParser < Parser
    def initialize(path)
      super(path)
      init_config(parent_dir)
      init_config(working_dir)
    end

    def delegate_execution
      filename = File.basename(@path, ".rb")
      class_name = filename.camelize
      cwb_benchmark = Cwb.const_get(class_name).new(working_dir)
      benchmark_suite.execute_suite([cwb_benchmark])
    end

    def validate
      check_file_exists(@path)
      require @path
    end

    private
    def working_dir
      File.dirname(@path)
    end

    def parent_dir
      File.dirname(working_dir)
    end
  end
end