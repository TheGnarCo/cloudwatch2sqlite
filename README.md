# cloudwatch2sqlite

A simple command line utility for receiving AWSCloudWatch NGINX log data and inserting it into a sqlite database for further analysis. Source data is ingested via STDIN stream directly from the `awslogs` cli utility.

## Installation

This utility was built using crystal lang. Install Crystal and run `make`.

## Usage

The `-h` flag lists all options. Specifying the sqlite3 database flag (via `-d`) as the FIRST option is required.

### Insert log data from stdin
`awslogs get /aws/elasticbeanstalk/web/var/log/nginx/access.log | ./cloudwatch2sqlite -d db/cloudwatch2sqlite`

### Truncate the database (Remove all rows from log_entries datable)
`./cloudwatch2sqlite -d db/cloudwatch2sqlite --truncate`

### Initialize database (create log_entries table)
`./cloudwatch2sqlite -d db/cloudwatch2sqlite --initialize`

## Contributing
1. Fork it (<https://github.com/your-github-user/cloudwatch2sqlite/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Nick Maloney / The Gnar Co.](https://github.com/ngmaloney) - creator and maintainer

## About The Gnar Company

<a href="https://www.thegnar.com/">
    <img alt="The Gnar Company" src="https://avatars0.githubusercontent.com/u/17011419?s=100&v=4" />
</a>

If you’re ready to dream it, we’re ready to build it. The Gnar is a custom software company ready to tackle your biggest challenges. Visit [The Gnar Company website](https://www.thegnar.com/) to learn more about us or [contact us](https://www.thegnar.com/contact) to see how we can help design and develop your product.
