class Redcap::App
  include Singleton
  
  attr_reader :server
  
  def self.run
    instance.run
  end
  
  def self.daemonise!
    # Daemon won't need these
    $stdin.reopen  '/dev/null'
    $stdout.reopen '/dev/null', 'w'
    $stderr.reopen '/dev/null', 'w'
    
    # Send to the background
    pid = fork
    if pid
      # This is in the context of the parent - save the pid file, then exit.
      File.open(instance.pid_file, 'w') { |file| file.puts pid }
      exit!
    end
  end
  
  def run
    update_procline
    
    EventMachine.epoll
    EventMachine.run do
      @server = EventMachine.start_server('127.0.0.1', 11000, Redcap::Server) do |connection|
        connection.logger = logger
      end
      
      setup_signal_handlers
    end
  end
  
  def stop!(signal)
    logger.info "Received #{signal} signal, stopping server."
    stop_listening
    forget_server
    stop
  end
  
  def die(message)
    $stderr.puts message
    logger.fatal message
    
    exit 1
  end
  
  private
  
  def update_procline
    $0 = 'redcap'
  end
  
  def log_file
    @log_file ||= '/var/log/redcap.log'
  end
  
  def pid_file
    @log_file ||= '/var/tmp/redcap.pid'
  end
  
  def logger
    @logger ||= begin
      logger                 = Logger.new(log_file)
      logger.formatter       = Logger::Formatter.new
      logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      logger.progname        = 'redcap'
      logger.level           = Logger::INFO
      
      logger
    end
  end
  
  def setup_signal_handlers
    %w{ QUIT TERM INT }.each do |signal|
      trap(signal) { stop!(signal) and exit! }
    end
  end
  
  def stop_listening
    EventMachine.stop_server(server) unless server.nil?
  end
  
  def forget_server
    @server = nil
  end
  
  def stop
    EventMachine.stop
  end
end
