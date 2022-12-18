require "option_parser"
require "sqlite3"
require "./log_entry_dao"
require "./parser"

class CLI
  property dao : LogEntryDao?

  def initialize
    @dao = nil

    parser = OptionParser.new do |p|
      p.banner = "Usage: cloudwatch2sqlite path_to_database"
      p.on("-d", "--database DATABASE", "Path to the sqlite database") do |db_path|
        setup_database db_path
      end

      p.on("--truncate", "Removes all log entries from database") do
        truncate_database!
      end

      p.on("--initialize", "Initializes the database") do
        initialize_database!
      end

      p.on("-h", "--help", "Show this help") do
        puts p
        exit
      end
    end

    parser.parse
    verify_dao!
  end

  def setup_database(db_path)
    if !File.exists?(db_path)
      puts "Error: #{db_path} is not a valid database path"
      exit
    end
    db_conn = DB.open "sqlite3://#{db_path}"
    @dao = LogEntryDao.new(db_conn)
  end

  def truncate_database!
    verify_dao!
    dao = @dao
    puts "Truncating tables"
    dao.clean if dao
    exit
  end

  def initialize_database!
    verify_dao!
    dao = @dao
    puts "Creating log_entries table"
    dao.create_table if dao
    exit
  end

  def verify_dao!
    dao = @dao
    if !dao
      puts "Database path is required"
      exit
    end
  end

  def run
    dao = @dao # https://crystal-lang.org/reference/1.6/syntax_and_semantics/if_var_nil.html
    STDIN.each_line do |line|
      log_entry = Parser.parse(line)
      if log_entry && dao && dao.save(log_entry)
        puts "Inserted row for #{log_entry.time}"
      else
        puts "Error inserting row"
      end
    end
  end
end
