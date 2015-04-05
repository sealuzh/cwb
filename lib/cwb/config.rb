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

    def initialize(node = nil)
      @node = node
    end

    def deep_fetch(*keys)
      @node.deep_fetch(*keys, default: "")
    end

    private
    def self.config_file(dir)
      File.join(dir, "node.yml")
    end
  end
end
