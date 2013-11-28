# Harness::resque

Log resque related metrics with Harness

## Installation

Add this line to your application's Gemfile:

    gem 'harness-resque'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install harness-resque

## In Jobs

```ruby
class Worker
  extend Resque::Plugins::Harness
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
