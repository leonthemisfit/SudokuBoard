# frozen_string_literal: true

require_relative 'errors'

module Sudoku
  module BoardValidate
    # rubocop:disable Metrics/MethodLength
    def group_valid?(indx, type = :row)
      values =
        case type
        when :row
          row(indx)
        when :column
          column(indx)
        when :grid
          grid(indx)
        else
          raise Errors::Board::InvalidGroupError
        end
        .map(&:value)
        .reject(&:nil?)

      values.uniq == values
    end
    # rubocop:enable Metrics/MethodLength

    def valid?
      rowv = (0..8).all? { |indx| group_valid?(indx) }
      colv = (0..8).all? { |indx| group_valid?(indx, :column) }
      gridv = (0..8).all? { |indx| group_valid?(indx, :grid) }

      rowv && colv && gridv
    end

    def equal?(other)
      raise Errors::Cell::OtherError unless other.is_a?(Board)

      (0..8).all? do |row|
        (0..8).all? do |col|
          self[row, col] == other[row, col]
        end
      end
    end

    def ==(other)
      equal?(other)
    end
  end
end
