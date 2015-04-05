require "simplecov"
class LineFilter < SimpleCov::Filter
  def matches?(source_file)
    source_file.lines.count < filter_argument
  end
end
SimpleCov.start do
  add_group "Long files" do |src_file|
    src_file.lines.count > 100
  end
  add_group "Short files", LineFilter.new(5)
  add_filter "spec/data"
end

require "pry"
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "cwb"

# Add gem root directory to LOAD_PATH
$LOAD_PATH << Cwb::root

def spec_data
  File.join(Cwb::root, "spec", "data")
end

# Requires supporting ruby files spec/data/ and its subdirectories.
Dir["spec/data/**/*.rb"].each { |f| require f }

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  
  config.order = "random"
end
