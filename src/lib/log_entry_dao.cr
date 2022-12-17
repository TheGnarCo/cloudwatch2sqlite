require "sqlite3"

class LogEntryDao
  property db_conn : DB::Database

  def initialize(db_conn)
    @db_conn = db_conn
  end

  def clean
    db_conn.exec("DELETE FROM log_entries;")
  end

  def create_table
    query = "CREATE TABLE IF NOT EXISTS log_entries(
    id INTEGER PRIMARY KEY,
    log_group TEXT NOT NULL,
    node TEXT,
    host TEXT,
    user TEXT,
    identity TEXT,
    time TEXT,
    method TEXT,
    request TEXT,
    status TEXT,
    bytes INTEGER,
    referrer TEXT,
    user_agent TEXT,
    virtual_host TEXT
    );}"
    db_conn.exec query
  end

  def save(log_entry)
    db_conn.exec "insert into log_entries values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
      nil,
      log_entry.log_group,
      log_entry.node,
      log_entry.host,
      log_entry.user,
      log_entry.identity,
      log_entry.time,
      log_entry.method,
      log_entry.request,
      log_entry.status,
      log_entry.bytes,
      log_entry.referrer,
      log_entry.user_agent,
      log_entry.virtual_host
  end
end
