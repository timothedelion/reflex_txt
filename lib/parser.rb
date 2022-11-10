# frozen_string_literal: true

require 'stringio'
require './lib/record'

class Parser
  attr_reader :io

  def initialize(lines:)
    @io = StringIO.new(lines)
  end

  def records
    io.map do |line|
      Record.new(line: line.chomp)
    end
  end
end
