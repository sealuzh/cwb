require "spec_helper"

RSpec.describe Cwb::Cli do
  let(:cli) { Cwb::Cli.new }
  let(:benchmarks_path) { File.join(spec_data, "benchmarks") }
  let(:sysbench_path) { File.join(benchmarks_path, "sysbench" , "sysbench.rb") }
  
  context "file" do
    it "should invoke the execute method of the given benchmark" do
      expect { cli.execute(sysbench_path) }.to output("execute sysbench in #{File.dirname(sysbench_path)}\n").to_stdout
    end
  end
end