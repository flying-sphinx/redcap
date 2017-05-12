require 'spec_helper'

describe Redcap do
  describe '.pid_for_port' do
    let(:socket) {
      double('socket', :write => nil, :read => '42', :close => nil)
    }

    before :each do
      allow(TCPSocket).to receive(:new).and_return(socket)
    end

    it "sends the given port to the socket" do
      expect(socket).to receive(:write).with("101\n")

      Redcap.pid_for_port(101)
    end

    it "returns the socket output as an integer" do
      expect(Redcap.pid_for_port(101)).to eq(42)
    end
  end
end
