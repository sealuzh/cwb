$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "cwb"

# Add gem root directory to LOAD_PATH
$LOAD_PATH << File.join(File.dirname(__FILE__), '..')

# Requires supporting ruby files spec/data/ and its subdirectories.
Dir["spec/data/**/*.rb"].each { |f| require f }

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  
  config.order = "random"
end
