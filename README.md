# cloudwatch2sqlite

A simple command line utility for receiving AWSCloudWatch NGINX log data and inserting it into a sqlite database for further analysis. Source data is ingested via STDIN stream.

## Installation

This utility was built using crystal lang. Install Crystal and run `make`.

## Usage

The `-h` flag lists all options. Specifying the sqlite3 database flag (via `-d`) as the FIRST option is required.

### Insert log data from stdin
`cat access.log | ./cloudwatch2sqlite -d db/cloudwatch2sqlite`

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
