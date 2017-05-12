require 'socket'
require 'singleton'
require 'logger'

module Redcap
  def self.pid_for_port(port, options = {})
    options[:server] ||= '127.0.0.1'
    options[:port]   ||= 11000

    socket = TCPSocket.new options[:server], options[:port]
    socket.write "#{port}\n"
    pid    = socket.read.to_i
    socket.close

    pid
  end
end

require 'redcap/app'
require 'redcap/version'
