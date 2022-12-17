# TODO: Write documentation for `Cloudwatch2sqlite`
require "./lib/parser"
require "./lib/log_entry_dao"
require "sqlite3"
require "option_parser"

module Cloudwatch2sqlite
  VERSION = "0.1.0"

  #TODO Add flag for specifing db 
  #TODO Add flag for initializing db
  db_conn = DB.open "sqlite3://./db/cloudwatch2sqlite.db"
  dao = LogEntryDao.new(db_conn)

  parser = OptionParser.new do |parser|
    parser.banner = "Usage: cloudwatch2sqlite path_to_database"
    parser.on("--truncate", "Removes all log entries from database") do
      puts "Truncating tables"
      dao.clean
      exit
    end

    parser.on("--initialize", "Initializes the database") do
      puts "Creating log_entries table"
      dao.create_table
      exit
    end
    parser.on("-h", "--help", "Show this help") do
      puts parser
      exit
    end
  end

  parser.parse

  STDIN.each_line do |line|
    log_entry = Parser.parse(line)
    if log_entry && dao.save(log_entry)
      puts "Inserted row for #{log_entry.time}" 
    else
      puts "Error inserting row"
    end
  end
end
