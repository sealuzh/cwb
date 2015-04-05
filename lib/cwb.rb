require "cwb/version"

module Cwb
  def self.root
    File.expand_path '../..', __FILE__
  end

  # Add inflection methods to string
  require "inflection"
  String.send(:include, Inflection)

  # Add deep_fetch to hash
  require "hash_extension"
  Hash.send(:include, HashExtension)

  require "cwb/benchmark"
  require "cwb/benchmark_suite"
  require "cwb/cli"
end
