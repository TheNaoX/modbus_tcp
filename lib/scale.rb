require 'rmodbus'

class Scale
  attr_accessor :connection, :net_weight, :gross_weight

  def initialize(host, port)
    @connection = ModBus::TCPClient.connect(host, port)

    read_scale_data
  end

  private

  def read_scale_data
    connection.with_slave(1) do |slave|
      registers = slave.input_registers[0..16]

      @net_weight   = registers.values_at(11,10).to_32f.shift
      @gross_weight = registers.values_at(13,12).to_32f.shift
    end
  end
end
