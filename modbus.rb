require 'rmodbus'

# Establish Connection
client = ModBus::TCPClient.connect('hi4050.hardysolutions.com', 502)

# Get the first slave connection
client.with_slave(1) do |slave|
  # Read input registers
  registers = slave.input_registers[0..16]

  # Get net weight and gross weight
  net_weight   = registers.values_at(11,10).to_32f.shift
  gross_weight = registers.values_at(13,12).to_32f.shift

  # Print
  puts "Net: #{net_weight}"
  puts "Gross: #{gross_weight}"
end
