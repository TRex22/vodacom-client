# Vodacom-Client
A client for the Vodacom-Client API.

This is an unofficial project and still a work in progress (WIP) ... more to come soon.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vodacom'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vodacom

## Usage

```ruby
  require 'vodacom'
  client  = Vodacom::Client.new(username: 'your key', password: 'your password from vodacom website', use_v4: true)

  phone_number = "27...."
  client.balance(phone_number)

  # use_v4 determines which API version is used
```

### Endpoints
  - Login
  - Balance

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Tests
To run tests execute:

    $ rake test

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trex22/vodacom-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the vodacom-client: project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/trex22/vodacom-client/blob/master/CODE_OF_CONDUCT.md).
