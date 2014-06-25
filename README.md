# Bumbleworks::Sequel

Allows you to use any database that [Sequel](http://redis.io) supports for your [Bumbleworks](http://github.com/bumbleworks/bumbleworks) process storage.  Just including this gem in your gemfile will automatically register the adapter by default.

## Installation

Add this line to your application's Gemfile:

    gem 'bumbleworks-sequel'

## Usage

Set Bumbleworks.storage to a Sequel database connection.  You can use Sequel.connect for this.  In a configure block, this looks like:

```ruby
Bumbleworks.configure do |c|
  c.storage = Sequel.connect('postgres://user:password@host:port/database_name')

  # optionally, set the table to use for the key-value store
  # (if not set, it will default to 'bumbleworks_documents')
  #
  # c.storage_options = { :sequel_table_name => 'bumbleworks_documents' }

  # ...
end
```

Happy bumbling!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
