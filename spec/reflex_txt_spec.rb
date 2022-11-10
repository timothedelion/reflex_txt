# frozen_string_literal: true

require './lib/record'
require './lib/parser'

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

    # Basic API
    raise unless "HL62110" == record.specification.identifier

    # Parsing
    raise unless expected_data == record.data
  end
end

EXAMPLE = "0000001HL62110A1Z2E3R4T5BGBL0001        wrench              000000001000000123AZER12
0000002HL62112A1Z2E3R4T52019-10-12T07:20:50.52ZJohn doe
0000003HL62110A1Z2E3R4T6BGBL0001        wrench              000000002000000122AZER12
0000004HL62112A1Z2E3R4T62019-10-12T07:20:50.52ZPaul bell
0000005HL62110A1Z2E3R4T7BGBL0001        wrench              000000001000000120AZER12
0000006HL62112A1Z2E3R4T72019-10-12T07:20:50.52ZDany dog"

RSpec.describe '#Parser' do
  it 'correctly return N records when given a multi-line string' do
    expected_second_record_data =
      { movement_id: "A1Z2E3R4T5", :date => "2019-10-12T07:20:50.52Z", :picker_name => "John doe" }

    records = Parser.new(lines: EXAMPLE).records

    raise unless records.size == 6
    raise unless records[1].data == expected_second_record_data
  end
end
