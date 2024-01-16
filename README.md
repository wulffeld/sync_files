# SyncFiles

A simple gem to synchronize web pages to files. I needed this functionality in a few scraping projects where fixtures representing web pages once in a while needed updating.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sync_files'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sync_files

## Usage

Create a `config/sync_files.yml` or `.sync_files.yml` file with content similar to the following:

```
groups:
  - settings:
      destination: "spec/fixtures"
    fixtures:
      - filename: "cnn_frontpage.html"
        url: "https://cnn.com"
```

The destination setting is where the HTML files will be written. The fixtures array contains a list of fixtures to be written. Each fixture has a filename and a url. The filename is the name of the file to be written. The url is the URL of the web page to be fetched and written to the file.

To synchronize the files, run the following command:

```
bundle exec rake sync_files:all
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wulffeld/sync_files. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/sync_files/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SyncFiles project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sync_files/blob/main/CODE_OF_CONDUCT.md).
