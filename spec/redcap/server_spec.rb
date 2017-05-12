require 'spec_helper'

describe Redcap::Server do
  describe '#receive_line' do
    let(:server) { Redcap::Server.new :spec }
    let(:logger) { double('logger', :info => nil) }

    before :each do
      server.logger = logger
      allow(server).to receive_messages(
        :`                              => '24',
        :close_connection_after_writing => nil,
        :send_data                      => nil
      )
    end

    it "sends the process id for a given port" do
      expect(server).to receive(:send_data).with('24')

      server.receive_line('101')
    end

    it "closes the connection once writing is finished" do
      expect(server).to receive(:close_connection_after_writing)

      server.receive_line('101')
    end

    it "logs the request" do
      expect(logger).to receive(:info).with('port: 101 -> pid: 24')

      server.receive_line('101')
    end
  end
end
