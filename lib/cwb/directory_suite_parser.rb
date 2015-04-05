require "cwb/directory_parser"

module Cwb
  class DirectorySuiteParser < DirectoryParser
    def self.suite_file_present?(path)
      File.exists?(self.suite_file_path(path)) && !File.read(self.suite_file_path(path)).empty?
    end

    # Suite file does definitely exist, otherwise the usual
    # direcoy parser implementation would have been chosen instead.
    def validate
      super
      require_all(read_lines(suite_file_path))
    end

    def benchmark_suite
      init_classes(read_lines(suite_file_path)).first
    end

    private

    def self.suite_file_path(path)
      File.join(path, "benchmark_suite.txt")
    end

    def suite_file_path
      self.class.suite_file_path(@path)
    end
  end
end
