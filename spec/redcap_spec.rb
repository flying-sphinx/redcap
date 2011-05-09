require 'spec_helper'

describe Redcap do
  describe '.pid_for_port' do
    let(:socket) { stub('socket', :write => nil, :read => '42', :close => nil) }
    
    before :each do
      TCPSocket.stub! :new => socket
    end
    
    it "sends the given port to the socket" do
      socket.should_receive(:write).with("101\n")
      
      Redcap.pid_for_port(101)
    end
    
    it "returns the socket output as an integer" do
      Redcap.pid_for_port(101).should == 42
    end
  end
end
