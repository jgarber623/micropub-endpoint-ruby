# micropub-endpoint-ruby

**A Ruby gem for discovering a URL's [Micropub](https://indieweb.org/Micropub) endpoint.**

[![Gem](https://img.shields.io/gem/v/micropub-endpoint.svg?style=for-the-badge)](https://rubygems.org/gems/micropub-endpoint)
[![Downloads](https://img.shields.io/gem/dt/micropub-endpoint.svg?style=for-the-badge)](https://rubygems.org/gems/micropub-endpoint)
[![Build](https://img.shields.io/travis/com/jgarber623/micropub-endpoint-ruby/master.svg?style=for-the-badge)](https://travis-ci.com/jgarber623/micropub-endpoint-ruby)
[![Dependencies](https://img.shields.io/depfu/jgarber623/micropub-endpoint-ruby.svg?style=for-the-badge)](https://depfu.com/github/jgarber623/micropub-endpoint-ruby)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/jgarber623/micropub-endpoint-ruby.svg?style=for-the-badge)](https://codeclimate.com/github/jgarber623/micropub-endpoint-ruby)
[![Coverage](https://img.shields.io/codeclimate/c/jgarber623/micropub-endpoint-ruby.svg?style=for-the-badge)](https://codeclimate.com/github/jgarber623/micropub-endpoint-ruby/code)

## Key Features

- Compliant with [Section 5.3](https://www.w3.org/TR/micropub/#endpoint-discovery) of [the W3C's Micropub Recommendation](https://www.w3.org/TR/micropub/).
- Supports Ruby 2.4 and newer.

## Getting Started

Before installing and using micropub-endpoint-ruby, you'll want to have [Ruby](https://www.ruby-lang.org) 2.4 (or newer) installed. It's recommended that you use a Ruby version managment tool like [rbenv](https://github.com/rbenv/rbenv), [chruby](https://github.com/postmodern/chruby), or [rvm](https://github.com/rvm/rvm).

micropub-endpoint-ruby is developed using Ruby 2.4.5 and is additionally tested against Ruby 2.5.3 using [Travis CI](https://travis-ci.com/jgarber623/micropub-endpoint-ruby).

## Installation

If you're using [Bundler](https://bundler.io), add micropub-endpoint-ruby to your project's `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'micropub-endpoint'
```

…and hop over to your command prompt and run…

```sh
$ bundle install
```

## Usage

### Basic Usage

With micropub-endpoint-ruby added to your project's `Gemfile` and installed, you may discover a URL's Micropub endpoint by doing:

```ruby
require 'micropub/endpoint'

endpoint = Micropub::Endpoint.discover('https://adactio.com')

puts endpoint # returns String: 'https://adactio.com/micropub'
```

This example will search `https://adactio.com` for a valid Micropub endpoint in accordance with the rules described in [the W3C's Micropub Recommendation](https://www.w3.org/TR/micropub/#endpoint-discovery). In this case, the program returns a string: `https://adactio.com/micropub`.

If no endpoint is discovered at the provided URL, the program will return `nil`:

```ruby
require 'micropub/endpoint'

endpoint = Micropub::Endpoint.discover('https://example.com')

puts endpoint.nil? # returns Boolean: true
```

### Advanced Usage

Should the need arise, you may work directly with the `Micropub::Endpoint::Client` class:

```ruby
require 'micropub/endpoint'

client = Micropub::Endpoint::Client.new('https://adactio.com')

puts client.response # returns HTTP::Response
puts client.endpoint # returns String: 'https://adactio.com/micropub'
```

### Exception Handling

There are several exceptions that may be raised by micropub-endpoint-ruby's underlying dependencies. These errors are raised as subclasses of `Micropub::Endpoint::Error` (which itself is a subclass of `StandardError`).

From [jgarber623/absolutely](https://github.com/jgarber623/absolutely) and  [sporkmonger/addressable](https://github.com/sporkmonger/addressable):

- `Micropub::Endpoint::InvalidURIError`

From [httprb/http](https://github.com/httprb/http):

- `Micropub::Endpoint::ConnectionError`
- `Micropub::Endpoint::TimeoutError`
- `Micropub::Endpoint::TooManyRedirectsError`

## Contributing

Interested in helping improve micropub-endpoint-ruby? Awesome! Your help is greatly appreciated. See [CONTRIBUTING.md](https://github.com/jgarber623/micropub-endpoint-ruby/blob/master/CONTRIBUTING.md) for details.

## Acknowledgments

micropub-endpoint-ruby wouldn't exist without Micropub and the hard work put in by everyone involved in the [IndieWeb](https://indieweb.org) movement.

micropub-endpoint-ruby is written and maintained by [Jason Garber](https://sixtwothree.org).

## License

micropub-endpoint-ruby is freely available under the [MIT License](https://opensource.org/licenses/MIT). Use it, learn from it, fork it, improve it, change it, tailor it to your needs.
