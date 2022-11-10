# frozen_string_literal: true

require './lib/parser'

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
