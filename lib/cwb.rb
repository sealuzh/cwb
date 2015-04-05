require "cwb/version"

module Cwb
  def self.root
    File.expand_path '../..', __FILE__
  end
  require "cwb/benchmark"
  require "cwb/benchmark_suite"
  require "cwb/cli"
end
