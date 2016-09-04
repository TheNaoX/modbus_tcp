require 'rmodbus'
require 'sinatra'
require 'pry'

set :port, 3001
set :bind, '0.0.0.0'

class Scale
  attr_accessor :net_weight, :gross_weight

  def initialize
    connect
  end

  def connect
    @client = ModBus::TCPClient.connect('hi4050.hardysolutions.com', 502)
  end

  def read_scale_data
    connect if @client.closed?
    @client.with_slave(1) do |slave|
      registers = slave.input_registers[0..16]
      @net_weight = registers.values_at(11,10).to_32f.shift
      @gross_weight = registers.values_at(13,12).to_32f.shift
    end
  end

  def perform
    read_scale_data
    puts "net: #{@net_weight}"
    puts "gross: #{@gross_weight}"
  end
end

get '/scale.xml' do
  scale = Scale.new
  scale.read_scale_data
  builder do |xml|
    xml.instruct!
    xml.scale do
      ['net', 'gross'].each do |type|
        xml.scaleItem do
          xml.value scale.send("#{type}_weight")
        end
      end
    end
  end
end
