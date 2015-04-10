require "spec_helper"

def init_paths(benchmarks_path)
  let(:benchmarks_path) { benchmarks_path }
  let(:sysbench_path) { File.join(benchmarks_path, "sysbench" , "sysbench.rb") }
  let(:sysbench_msg) { "execute sysbench in #{File.dirname(sysbench_path)}\n" }
  let(:shell_example_path) { File.join(benchmarks_path, "shell-example" , "shell_example.rb") }
  let(:shell_example_msg) { "execute shell-example in #{File.dirname(shell_example_path)}\n" }
  let(:my_custom_benchmark_path) { File.join(benchmarks_path, "my-custom-benchmark", "my_custom_benchmark.rb") }
  let(:my_custom_benchmark_msg) { "execute my-custom-benchmark in #{File.dirname(my_custom_benchmark_path)}\n" }
  let(:failing_benchmark_path) { File.join(benchmarks_path, "disabled", "disabled.rb") }
end

RSpec.describe Cwb::Cli do
  let(:cli) { Cwb::Cli.new }
  let(:success_msg) { "Notify finished postprocessing.\n" }
  let(:error_msg) { "Notify failure on running: " }
  init_paths(File.join(spec_data, "benchmarks"))

  context "file" do
    it "should invoke the execute method of the given benchmark" do
      expect { cli.execute(sysbench_path) }.to output(sysbench_msg + success_msg).to_stdout
    end

    it "should invoke the execute method when called from the command line" do
      expect(`#{File.join(Cwb::root, "bin", "cwb")} execute #{sysbench_path}`).to eq(sysbench_msg + success_msg)
      expect($?.exitstatus).to eq(0)
    end

    it "should invoke the execute method when called from the command line via ruby" do
      expect(`cd #{File.dirname(sysbench_path)} && ruby -I "#{File.join(Cwb::root, "lib")}" -r "#{sysbench_path}" -e "Sysbench.new.execute"`).to eq(sysbench_msg)
      expect($?.exitstatus).to eq(0)
    end
  end

  context "directory" do
    it "should execute all enabled benchmarks (i.e., contained in the benchmarks.txt) in correct order" do
      expect { cli.execute(benchmarks_path) }.to output(sysbench_msg + shell_example_msg + success_msg).to_stdout
    end

    it "should notify a failed on running message on error" do
      expect { cli.execute(failing_benchmark_path) }.to output(/#{error_msg}/).to_stdout & raise_error
    end
  end

  context "directory with suite" do
    init_paths(File.join(spec_data, "benchmarks-suite"))

    it "should execute the benchmarks of the provided suite in correct order" do
      expect { cli.execute(benchmarks_path) }.to output(sysbench_msg + my_custom_benchmark_msg + success_msg).to_stdout
    end
  end
end
