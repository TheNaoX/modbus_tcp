require 'spec_helper'

describe Scale do
  describe '#connection' do
    it 'returns a connection' do
      scale = Scale.new('hi4050.hardysolutions.com', 502)
      expect(scale.connection).to be_kind_of ModBus::TCPClient
    end

    it 'establishes the connection with the scale' do
      scale = Scale.new('hi4050.hardysolutions.com', 502)

      expect(scale.connection.ipaddr).to eq "hi4050.hardysolutions.com"
      expect(scale.connection.port).to eq 502
    end
  end

  describe '#net_weight' do
    it 'returns the net weight' do
      scale = Scale.new('hi4050.hardysolutions.com', 502)

      expect(scale.net_weight).to be_kind_of Float
    end
  end

  describe '#gross_weight' do
    it 'returns the net weight' do
      scale = Scale.new('hi4050.hardysolutions.com', 502)

      expect(scale.gross_weight).to be_kind_of Float
    end
  end
end
