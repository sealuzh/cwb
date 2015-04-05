require "singleton"
require "cwb/config"

module Cwb
  class Client
    include Singleton

    def reconfigure(config)
      @config = config
    end

    def initialize
      @config = Cwb::Config.new
    end

    def deep_fetch(*keys)
      @config.deep_fetch(*keys)
    end

    def submit_metric(metric_definition_id, time, value)
      puts "#{metric_definition_id},#{time},#{value}"
    end
  end
end
