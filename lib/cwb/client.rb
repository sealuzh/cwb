require "singleton"
require "csv"
require "faraday"
require "faraday_middleware"
require "cwb/config"

module Cwb
  # Serves as cwb-server client library in cloud VMs (if configured against a cwb-server)
  # or as standalone utility otherwise where cwb-server communication (e.g., metric submission)
  # is logged to stdout.
  # @api
  class Client
    include Singleton

    # RESTful endpoints
    VM_INSTANCE = "virtual_machine_instances"
    METRIC_OBSERVATIONS = "metric_observations"

    # Reconfigures the Client with a configuration object against a cwb-server.
    # @api private
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
    # @example @cwb.deep_fetch("sysbench", "commands")
    # @return an empty string if attribute cannot be found
    def deep_fetch(*keys)
      @config.deep_fetch(*keys)
    end

    # Submit a single metric
    # @param metric_definition_id [String] the name of the CWB metric
    # @param time [Integer] the UNIX timestamp when the metric was captured
    # @param value [String (nominal-scale) or Numeric (otherwise)] the value of the metric
    def submit_metric(metric_definition_id, time, value)
      if @config.complete?
        submit_remote_metric(metric_definition_id, time, value)
      else
        puts "#{metric_definition_id},#{time},#{value}"
      end
    end

    # Submit a csv file with metrics
    # @param metric_definition_id [String] the name of the CWB metric
    # @param csv_file [String] the path to the csv file containing the metrics
    # @note the csv file must:
    #       * have two columns: 'time' [Integer], 'value' [String (nominal-scale) or Numeric (otherwise)]
    #       * be formatted without headers
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
    # @note The cwb-server will shutdown all VMs of this executions.
    def notify_finished_execution
      if @config.complete?
        post_notify("/#{VM_INSTANCE}/complete_postprocessing", true)
      else
        puts "Notify finished postprocessing."
      end
    end

    # Notifies the cwb-server that the benchmark failed during the execution
    # @note The cwb-server will shutdown all VMs of this execution after a timeout (~15').
    def notify_failed_execution(message = "")
      if @config.complete?
        post_notify("/#{VM_INSTANCE}/complete_benchmark", false, message)
      else
        puts "Notify failure on running. (message suppressed to avoid redundant logging)"
      end
    end


    private

      # Create a standalone instance with an empty config per default
      def initialize
        @config = Cwb::Config.new
      end

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
