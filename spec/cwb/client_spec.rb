require "spec_helper"

RSpec.describe Cwb::Client do
  let(:client) { Cwb::Client.instance }

  context "cwb-server" do

  end

  context "local" do
    let(:commands) { [ "sysbench --test=cpu --max-prime-number=20000 run",
                       "sysbench --test=io run", ] }
    let(:test_config) { File.join(spec_data, "benchmarks", "sysbench") }
    let(:metrics_file) { File.join(test_config, "metrics.csv") }
    before { Cwb::Client.instance.reconfigure(Cwb::Config.from_dir(test_config)) }

    it "should log single metric submission to the console" do
      expect { client.submit_metric("time", "0", "340") }.to output("time,0,340\n").to_stdout
    end

    it "should log bulk metric submission to the console" do
      expect { client.submit_metrics("cpu_load", metrics_file) }.to output("0,30\n500,40\n1000,50\n").to_stdout
    end

    it "should return an empty string for non-configured attributes" do
      expect(client.deep_fetch("non-existing", "attribute")).to be_empty
    end

    it "should return attributes from the config file" do
      expect(client.deep_fetch("sysbench", "commands")).to  eq(commands)
    end
  end
end
