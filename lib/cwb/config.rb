require "yaml"

module Cwb
  class Config
    attr_accessor :node

    def self.exists_in_dir?(dir)
      File.exists?(self.config_file(dir))
    end

    def self.from_dir(dir)
      self.from_file(self.config_file(dir))
    end

    def self.from_file(file)
      self.new(YAML.load_file(file))
    end

    def initialize(node = {})
      @node = node
    end

    # TODO: Consider returning nil as default value.
    # The current deep_fetch implementation doesn't support { default: nil }
    def deep_fetch(*keys)
      @node.deep_fetch(*keys, default: "")
    end

    # Determines whether all strictly required attributes
    # that are necessary for communication with the cwb-server
    # are available.
    def complete?
      args = [server, provider_name, provider_instance_id]
      args.map { |value| value.empty? }.none?
    end

    def server
      deep_fetch("cwb", "server")
    end

    def provider_name
      deep_fetch("benchmark", "provider_name")
    end

    def provider_instance_id
      deep_fetch("benchmark", "provider_instance_id")
    end


    private

      def self.config_file(dir)
        File.join(dir, "node.yml")
      end
  end
end
