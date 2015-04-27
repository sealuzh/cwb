# Cloud WorkBench Client (CWB Client)

This command line utility [cwb-client] consitutes the cwb client library in cloud VMs and supports local benchmark testing.
CWB Client helps you implementing your own suites of benchmarks and optionally integrates them with the CWB framework.


## Quicklinks
* CWB Server: https://github.com/sealuzh/cloud-workbench
* CWB Cookbook *(Chef)*: https://github.com/sealuzh/cwb-benchmarks/tree/master/cwb
* [![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/gems/cwb/)
    * [Cwb::Client Docs](http://www.rubydoc.info/gems/cwb/Cwb/Client)
* [![Gem Version](https://badge.fury.io/rb/cwb.svg)](https://rubygems.org/gems/cwb)


## Installation

Add this line to your application's Gemfile:

    gem 'cwb', '~> 0.1.0'

And then execute:

    bundle

Or install it yourself as:

    gem install cwb


## Development

### Run Tests

Guard will watch your files and automatically run the tests. Type `all` to run all tests.

```bash
guard
```

### Publish to RubyGems (only owners)

Bump version in `lib/cwb/version.rb`

```bash
rake build
gem push pkg/cwb-0.1.X.gem
git tag -a v0.1.X -m 'COMMENT'
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cwb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
