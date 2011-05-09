class Redcap::Server < EventMachine::Protocols::LineAndTextProtocol
  attr_accessor :logger
  
  def receive_line(line)
    port = line.to_i
    pid  = pid_for_port(port)
    
    logger.info "port: #{port} -> pid: #{pid}"
    
    send_data pid
    close_connection_after_writing
  end
  
  private
  
  def pid_for_port(port)
    `lsof -i :#{port} | grep ssh | awk '{print $2}'`[/\d+/] || 'Unknown'
  end
end
