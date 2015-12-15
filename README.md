# WebCrawler

WebCrawler is a gem for exploring the web. In it's current iteration it is able to, slowly, build a tree of assets and child links

## Installation


$ gem install web_crawler

## Usage

To output JSON to the console:

````bash
bin/web_crawler -u http://www.jeffreyleebaird.com/
````
To output JSON to a file:

````bash
bin/web_crawler -u http://www.jeffreyleebaird.com/
````
## Development
````bash
$git clone git@github.com:jeffreybaird/web_crawler.git
$cd web_crawler
$bundle install
$rake test
````

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jeffreybaird/web_crawler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
