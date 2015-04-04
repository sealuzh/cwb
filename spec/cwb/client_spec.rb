require "spec_helper"

RSpec.describe Cwb::Client do
  let(:client) { Cwb::Client.new }
  
  context "cwb-server" do
    
  end
  
  context "local" do
    it "should log metrics to the console " do
      expect { client.submit_metric("time", "0", "340") }.to output("time,0,340\n").to_stdout
    end
    
    it "should return an empty string for non-configured attributes" do
      expect(client.attribute("cli_options")).to be_empty
    end
  end
end
