# TODO: Write documentation for `Cloudwatch2sqlite`
module Cloudwatch2sqlite
  VERSION = "0.1.0"

  class LogEntry
    property log_group : String
    property node : String
    property host : String?
    property user : String?
    property identity : String?
    property time : Time?
    property method : String
    property request : String
    property status : String?
    property bytes : Int32?
    property referrer : String?
    property user_agent : String?
    property virtual_host : String?

    def initialize(log_group, node, host, identity, user, time, method, request, status, bytes, referrer, user_agent, virtual_host)
      @log_group = log_group
      @node = node
      @host = host
      @identity = identity
      @user = user
      @time = time
      @method = method
      @request = request
      @status = status
      @bytes = bytes
      @referrer = referrer
      @user_agent = user_agent
      @virtual_host = virtual_host
    end
  end

  module Parser
    CLOUDWATCH_NGINX_REGEX = /(?P<log_group>.*?) (?P<node>.*?) (?P<host>[\d\.]+) (?P<identity>\S*) (?P<user>\S*) \[(?P<time>.*?)\] "(?P<method>.*?) (?P<request>.*?) HTTP.*" (?P<status>\d+)\s(?P<bytes>\S*) "(?P<referrer>.*?)" "(?P<user_agent>.*?)" "(?P<virtual_host>.*)"/
    LOG_DATE_FORMAT = "%d/%b/%Y:%H:%M:%S %Z"

    def self.parse(row)
      parsed = row.match(CLOUDWATCH_NGINX_REGEX)
      self.to_log_entry parsed
    end

    def self.to_log_entry(row : Regex::MatchData?)
      time = Time.parse!(row["time"], LOG_DATE_FORMAT) if row && row["time"]
      LogEntry.new(
        log_group: row["log_group"],
        node: row["node"],
        host: row["host"],
        user: row["user"],
        identity: row["identity"],
        time: time,
        method: row["method"],
        request: row["request"],
        status: row["status"],
        bytes: row["bytes"].to_i,
        referrer: row["referrer"],
        user_agent: row["user_agent"],
        virtual_host: row["virtual_host"]
      ) if row
    end
  end

  STDIN.each_line do |line|
    parsed = Parser.parse(line)
    puts parsed.host if parsed && parsed.host
    puts parsed.request if parsed && parsed.request
  end
end
