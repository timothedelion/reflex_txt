# frozen_string_literal: true

require './lib/record'

RSpec.describe '#Record' do
  it 'correctly parses one line when given a string' do
    line = "0000001HL62110A1Z2E3R4T5BGBL0001        wrench              000000001000000123AZER12"
    expected_data = {
      movement_id: "A1Z2E3R4T5",
      product_id: "BGBL0001        ",
      product_name: "wrench              ",
      movement_quantity: "000000001",
      remaining_quantity: "000000123",
      item_location: "AZER12",
    }

    record = Record.new(line: line)

    raise unless expected_data == record.data
  end
end
