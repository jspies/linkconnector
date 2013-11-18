# Linkconnector

This gem provides an easy to use interface for searching the Linkconnector API. Linkconnector provides APIs for sites like iStockphoto and Thinkstock among lots of others here: http://www.linkconnector.com/featuredmerchants.htm. You will need an API key from linkconnector.


## Installation

Add this line to your application's Gemfile:

    gem 'linkconnector'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linkconnector

## Usage

First configure linkconnector to use your API key. In Rails I do this in an initializer

```
require "linkconnector"

Linkconnector.configure(
  api_key: "YOUR API KEY",
  default_merchant_ids: ["11111"] # scope all requests to these merchants
)
```

Use Linkconnector::Item to search for results. The syntax is similar to ActiveRelation but not 100% equivalent.

```
@images = Linkconnector::Item.search("cats").type("vector").limit(10).page(1).all
```

You can limit you searches to specific merchants. Otherwise linkconnector will return results from any merchant that you have access to.

```
Linkconnector::Item.merchant("THIS COOL MERCHANT ID").search("puppies").all
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
