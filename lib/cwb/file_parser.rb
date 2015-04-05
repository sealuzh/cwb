require "cwb/parser"

module Cwb
  class FileParser < Parser
    def delegate_execution
      filename = File.basename(@path, ".rb")
      clazz = filename.camelize.constantize
      cwb_benchmark = clazz.new(File.dirname(file_path))
      benchmark_suite.execute_suite([cwb_benchmark])
    end

    def validate
      check_file_exists(file_path)
      require_relative file_path
    end

    private
      def file_path
        File.expand_path(@path)
      end
  end
end