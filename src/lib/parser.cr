require "./log_entry"

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