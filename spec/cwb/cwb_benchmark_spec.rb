require "spec_helper"

RSpec.describe CwbBenchmark do
  context "sublasses" do
    let(:sysbench) { Sysbench.new }

    it "should return the cwb metrics list" do
      expect(sysbench.cwb_metrics).to eq(["cpu_model_name"])
    end

    it "should get injected a CwbClient instance" do
      expect(sysbench.cwb).to_not be_nil
    end
  end
end