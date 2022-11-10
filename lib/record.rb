# frozen_string_literal: true

require './lib/specification'

class Record
  attr_reader :line

  PREFIX_SIZE = 7 # Size of the '0000001' prefix
  SPECIFICATION_IDENTIFIER_SIZE = 7 # Size of the spec identifier 'HL62110'

  def initialize(line:)
    @line = line
  end

  def specification
    @_specification ||= Specification.from_identifier(specification_identifier) # memoized
  end

  def data
    @_data ||= parse(line, specification) # memoized
  end

  def to_s
    `<Record @data=#{data} @specification_identifier=#{specification.identifier}>`
  end

  private

  def parse(line, specification)
    line = line[PREFIX_SIZE + SPECIFICATION_IDENTIFIER_SIZE ..line.size - 1]

    data = {}
    specification.definition.each do |attribute_name, size|
      data[attribute_name.to_sym] = line[0..size - 1]
      line = line[size..line.size - 1]
    end

    data
  end

  def specification_identifier
    @_specification_identifier ||= line[PREFIX_SIZE ..PREFIX_SIZE + SPECIFICATION_IDENTIFIER_SIZE - 1] # memoized
  end
end
