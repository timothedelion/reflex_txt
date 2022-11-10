# frozen_string_literal: true

require './lib/specification'

RSpec.describe '#Specification' do
  it 'exposes headers' do
    expected_headers = [
      :movement_id,
      :product_id,
      :product_name,
      :movement_quantity,
      :remaining_quantity,
      :item_location
    ]
    expected_definition = [
      ["movement_id", 10],
      ["product_id", 16],
      ["product_name", 20],
      ["movement_quantity", 9],
      ["remaining_quantity", 9],
      ["item_location", 6]
    ]

    specification = Specification.from_identifier("HL62110")

    raise unless expected_headers == specification.headers
    raise unless "HL62110" == specification.identifier
    raise unless expected_definition == specification.definition
  end
end
