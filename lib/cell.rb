# frozen_string_literal: true

require_relative 'errors'

module Sudoku
  class Cell
    attr_reader :value

    def initialize(value = nil, constant = false)
      @value = value
      @constant = constant
      @marks = []
    end

    def to_s
      if value.nil?
        '*'
      else
        value.to_s
      end
    end

    def value=(val)
      raise Errors::Cell::ConstantError if constant?

      if val == '*'
        clear
      else
        raise Errors::Cell::ValueTypeError unless val.is_a? Integer
        raise Errors::Cell::ValueError unless (1..9).include?(val)

        @value = val
        @marks = []
        @constant = true
      end
    end

    def constant?
      @constant
    end

    def clear(rm_constant = true)
      @value = nil
      @marks = []
      @constant = false if rm_constant
    end

    def mark(val)
      raise Errors::Cell::ValueError unless (1..9).include?(val)

      @marks << val unless @marks.include?(val)
    end

    def marks
      @marks.clone
    end

    def erase(val)
      raise Errors::Cell::ValueError unless (1..9).include?(val)

      @marks.delete(val)
    end

    def equal?(other)
      raise Errors::Cell::OtherError unless other.is_a?(Cell)

      @value == other.value && @marks == other.marks
    end

    def ==(other)
      equal?(other)
    end
  end
end
