# Monzo

A simple interface to make requests to the Monzo API. Full API documentation can be found at [https://monzo.com/docs/](https://monzo.com/docs/).

Before using this gem please ensure you read [Monzo's update on their API](https://monzo.com/blog/2017/05/11/api-update/) ensuring you understand Monzo's development plans and are happy that they are likely to introduce backwards-incompatible changes to the API when developing the new Current Account functionality.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "monzo"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install monzo

## Usage

### Introduction

The Monzo API implements OAuth 2.0 to allow users to log in to applications without exposing their credentials. The process involves several steps:

1. Acquire an access token, and optionally a refresh token
2. Use the access token to make authenticated requests
3. If you were issued a refresh token: refresh the access token when it expires

Before you begin, you will need to create a client in the developer tools. To understand how to acquire an access token see the [Monzo API documentation](https://monzo.com/docs/#authentication)

Once you have acquired an access token you can configure the gem to use it. Firstly require the gem:

```ruby
require "monzo"
```

Then configure your access token:

```ruby
Monzo.configure("access_token")
```

After you have set your access token you can now make requests.

### Accounts

Accounts represent a store of funds, and have a list of transactions. [Docs](https://monzo.com/docs/#accounts)

```ruby
# Find all Monzo Accounts
Monzo::Account.all
```

### Pots

A Pot is a place to keep some money separate from your main spending account.
[Docs](https://monzo.com/docs/#pots)

```ruby
# Find all Monzo Pots
Monzo::Pot.all

# Find a pot with the given pot id.
Monzo::Pot.find(pot_id)

# Move money into a pot
account_id = Monzo::Account.all.last.id # The account to withdraw from
pot = Monzo::Pot.all.first # Get the first pot
pot.balance #=> eg. 5000

pot.deposit!(100, account_id)
pot.balance  #=> eg. 5100

# Move money out of a pot
account_id = Monzo::Account.all.last.id
pot = Monzo::Pot.all.first
pot.balance #=> eg. 5000

pot.withdraw!(100, account_id)
pot.balance  #=> eg. 4900
```

The `deposit!` and `withdrawl!` methods accept an optional `dedupe_id` parameter. It's used to prevent duplicate transactions and should remain static between retries to ensure only one deposit/withdrawl is created. If you don't provide one, a random string will be generated for each deposit/withdrawl. You should **always** provide this if there is a chance the transaction will be retried.

```ruby
dedupe_id = 'SomeniqueDeDuplicationString' # Store this and use it for retries.
pot.deposit!(100, account_id, dedupe_id)
```

### Balance

Retrieve information about an account’s balance. [Docs](https://monzo.com/docs/#balance)

```ruby
# Find the balance of the given account id
Monzo::Balance.find(account_id)
```

### Transactions

Transactions are movements of funds into or out of an account. Negative transactions represent debits (ie. spending money) and positive transactions represent credits (ie. receiving money). [Docs](https://monzo.com/docs/#transactions)

```ruby
# Find a transaction with the given transaction id.
Monzo::Transaction.find(transaction_id)

# Find all the transactions for a given account id.
Monzo::Transaction.all(account_id)

# Create an annotation for a given transaction id.
metadata = { :foo => "bar" }
Monzo::Transaction.create_annotation(transaction_id, metadata)
```

### Feed Items

The Monzo app is organised around the feed – a reverse-chronological stream of events. Transactions are one such feed item, and your application can create its own feed items to surface relevant information to the user. [Docs](https://monzo.com/docs/#feed-items)

```ruby
# Create a feed item on a user's feed.
feed_item_type = "basic"
feed_item_params = {
  :title => "Hello World",
  :image_url => "https://www.example.com/image.png"
}
url = "https://www.example.com"
Monzo::FeedItem.create(account_id, feed_item_type, feed_item_params, url)
```

### Webhooks

Webhooks allow your application to receive real-time, push notification of events in an account. [Docs](https://monzo.com/docs/#webhooks)

```ruby
# Create a webhook for the given account id.
Monzo::Webhook.create(account_id, "https://example.com")

# Find all webhooks for a given account id.
Monzo::Webhook.all(account_id)

# Delete a webhook.
Monzo::Webhook.delete(webhook_id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/murraysum/monzo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
