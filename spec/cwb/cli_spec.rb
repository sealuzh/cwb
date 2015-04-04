require "spec_helper"

RSpec.describe Cwb::Cli do
  let(:cli) { Cwb::Cli.new }
  let(:benchmarks_path) { File.join(spec_data, "benchmarks") }
  let(:sysbench_path) { File.join(benchmarks_path, "sysbench" , "sysbench.rb") }
  let(:shell_example_path) { File.join(benchmarks_path, "shell-example" , "shell_example.rb") }
  
  context "file" do
    it "should invoke the execute method of the given benchmark" do
      expect { cli.execute(sysbench_path) }.to output("execute sysbench in #{File.dirname(sysbench_path)}\n").to_stdout
    end
  end
  
  context "directory" do
    it "should execute all enabled benchmarks (i.e., contained in the benchmarks.txt) in correct order" do
      expect { cli.execute(benchmarks_path) }.to output("execute sysbench in #{File.dirname(sysbench_path)}\nexecute shell-example in #{File.dirname(shell_example_path)}\n").to_stdout
    end
  end
end
