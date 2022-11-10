# frozen_string_literal: true

class Specification
  attr_reader :identifier, :definition

  def initialize(identifier:, definition:)
    @identifier = identifier
    @definition = definition
  end

  def headers
    definition.map(&:first).map(&:to_sym)
  end

  def to_s
    `<Specification @name=#{identifier}`
  end

  class << self
    def from_identifier(identifier)
      SPECIFICATIONS[identifier]
    end
  end
end

SPECIFICATIONS = {
  'HL62110' =>
    Specification.new(identifier: 'HL62110', definition: [
      ['movement_id', 10],
      ['product_id', 16],
      ['product_name', 20],
      ['movement_quantity', 9],
      ['remaining_quantity', 9],
      ['item_location', 6]
    ]),
  'HL62111' =>
    Specification.new(identifier: 'HL62111', definition: [
      ['product_id', 16],
      ['product_name', 20],
      ['movement_quantity', 9],
      ['item_location', 6]
    ]
    ),
  'HL62112' =>
    Specification.new(identifier: 'HL62112', definition: [
      ['movement_id', 10],
      ['date', 23],
      ['picker_name', 30],
    ])
}
