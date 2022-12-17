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
