require 'spec_helper'

describe Redcap::Server do
  describe '#receive_line' do
    let(:server) { Redcap::Server.new :spec }
    let(:logger) { stub('logger', :info => nil) }
    
    before :each do
      server.logger = logger
      server.stub!(
        :`                              => '24',
        :close_connection_after_writing => nil,
        :send_data                      => nil
      )
    end
    
    it "sends the process id for a given port" do
      server.should_receive(:send_data).with('24')
      
      server.receive_line('101')
    end
    
    it "closes the connection once writing is finished" do
      server.should_receive(:close_connection_after_writing)
      
      server.receive_line('101')
    end
    
    it "logs the request" do
      logger.should_receive(:info).with('port: 101 -> pid: 24')
      
      server.receive_line('101')
    end
  end
end
