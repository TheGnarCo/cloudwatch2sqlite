# TODO: Write documentation for `Cloudwatch2sqlite`
require "./lib/cli"

module Cloudwatch2sqlite
  VERSION = "0.1.0"

  cli = CLI.new
  cli.run
end
