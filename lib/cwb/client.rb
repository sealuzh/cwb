require "singleton"
require "csv"
require "faraday"
require "faraday_middleware"
require "cwb/config"

module Cwb
  class Client
    include Singleton

    # RESTful endpoints
    VM_INSTANCE = "virtual_machine_instances"
    METRIC_OBSERVATIONS = "metric_observations"

    def initialize
      @config = Cwb::Config.new
    end

    def reconfigure(config)
      @config = config
      if @config.complete?
        @connection = Faraday.new(:url => "http://#{@config.server}") do |f|
          f.request :multipart
          f.request :json
          f.adapter Faraday.default_adapter
        end
      end
    end

    # Securly access nested attributes.
    # Example: @cwb.deep_fetch("sysbench", "commands")
    def deep_fetch(*keys)
      @config.deep_fetch(*keys)
    end

    # Submit a single metric
    def submit_metric(metric_definition_id, time, value)
      if @config.complete?
        submit_remote_metric(metric_definition_id, time, value)
      else
        puts "#{metric_definition_id},#{time},#{value}"
      end
    end

    # Submit a csv file with metrics
    def submit_metrics(metric_definition_id, csv_file)
      if @config.complete?
        submit_remote_metrics(metric_definition_id, csv_file)
      else
        CSV.foreach(csv_file) do |row|
          puts row.join(',')
        end
      end
    end

    # Notifies the cwb-server that the benchmark successfully completed.
    # The cwb-server will shutdown all VMs of this executions.
    def notify_finished_execution
      if @config.complete?
        post_notify("/#{VM_INSTANCE}/complete_postprocessing", true)
      else
        puts "Notify finished postprocessing."
      end
    end

    # Notifies the cwb-server that the benchmark failed during the execution
    # The cwb-server will shutdown all VMs of this execution after a timeout (~10').
    def notify_failed_execution(message = "")
      if @config.complete?
        post_notify("/#{VM_INSTANCE}/complete_benchmark", false, message)
      else
        puts "Notify failure on running: #{message}"
      end
    end


    private

      def submit_remote_metric(metric_definition_id, time, value)
        body = {
            :metric_observation => {
              metric_definition_id: metric_definition_id,
              provider_name: @config.provider_name,
              provider_instance_id: @config.provider_instance_id,
              time: time,
              value: value
            }
        }
        @connection.post "/#{METRIC_OBSERVATIONS}", body
      end

      def submit_remote_metrics(metric_definition_id, csv_file)
        payload = {
            metric_observation: {
              metric_definition_id: metric_definition_id,
              provider_name: @config.provider_name,
              provider_instance_id: @config.provider_instance_id,
              file: Faraday::UploadIO.new(csv_file, 'text/csv')
            }
        }
        @connection.post "/#{METRIC_OBSERVATIONS}/import", payload
      end

      def post_notify(path, success = true, message = "", opts = {})
        body = {
            provider_name: @config.provider_name,
            provider_instance_id: @config.provider_instance_id,
            success: success.to_s,
            message: message,
        }.merge(opts)
        @connection.post path, body
      end
  end
end
