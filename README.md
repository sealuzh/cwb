# CWB

Provides Cloud WorkBench (CWB) infrastructure for cloud VMs and local testing.
CWB helps you implement your own suites of benchmarks and optionally integrates them with the CWB framework.
See https://github.com/sealuzh/cloud-workbench

## TODO

* Migrate to alternative HTTP library because the currently used rest-client has been removed in Chef 12 (https://github.com/chef/chef/pull/1409)
  * HTTParty: http://johnnunemaker.com/httparty/
  * Excon.io: https://github.com/excon/excon
* Think about shared utility for paths
  * Chef Recipe 'cwb
    * INPUT: node (i.e., cwb.base_dir); [benchmark name]
    * OUTPUT: general cwb paths (i.e. config, base_dir); [benchmark specific paths (i.e. class_file_path)]
  * Client gem 'cwb'
    * INPUT: file or directory path => parse node (i.e. cwb.base_dir); [benchmark name]
    * OUTPUT: general cwb paths (i.e. config, base_dir); [benchmark specific paths (i.e. class_file_path)]
* Consider checking cwb-server connection before starting the execution because it doesn't make sense to start a benchmark if the cwb-server is not reachable
* Validations including meaningful error messages on `cwb validate`
  * Wrong class name
  * Missing inheritance
  * No #execute method present
* Write test that covers reading config from node.yml => especially the @config.deep_fetch behavior/issue!
* Faraday DOC links:
  * Github: https://github.com/lostisland/faraday
  * Changes in v0.8 (separated middleware e.g., for JSON): https://github.com/lostisland/faraday_middleware/wiki/Changes-0.8

## Installation

Add this line to your application's Gemfile:

    gem 'cwb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cwb

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cwb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
