# frozen_string_literal: true

require 'yaml'

require_relative 'cell'
require_relative 'errors'
require_relative 'constants'

require_relative 'board_static'
require_relative 'board_serial'
require_relative 'board_validate'

module Sudoku
  class Board
    extend BoardStatic
    include BoardSerial
    include BoardValidate

    def initialize(serial = '', serializer = :yaml)
      @cells =
        if serial.empty?
          (0..8).map { (0..8).map { Cell.new } }
        else
          Board.deserialize(serial, serializer)
        end
    end

    def [](row, col)
      raise Errors::Board::LocationError unless (0..8).include?(row)
      raise Errors::Board::LocationError unless (0..8).include?(col)

      rows[row][col]
    end

    def []=(row, col, val)
      raise Errors::Board::LocationError unless (0..8).include?(row)
      raise Errors::Board::LocationError unless (0..8).include?(col)

      @cells[row][col].value = val
    end

    def rows
      @cells
    end

    def row(ind)
      raise Errors::Board::LocationError unless (0..8).include?(ind)

      rows[ind]
    end

    def columns
      (0..8).map do |col|
        (0..8).map do |row|
          @cells[row][col]
        end
      end
    end

    def column(ind)
      raise Errors::Board::LocationError unless (0..8).include?(ind)

      columns[ind]
    end

    def grids
      Sudoku::Constants::GRID_RANGES.map do |rows, cols|
        @cells[rows].map { |row| row[cols] }.flatten
      end
    end

    def grid(ind)
      raise Errors::Board::LocationError unless (0..8).include?(ind)

      grids[ind]
    end

    def each(&block)
      (0..8).each do |row|
        (0..8).each { |col| block.call(row, col, self[row, col]) }
      end
    end

    def set_cell(row, col, cell)
      raise Errors::Board::LocationError unless (0..8).include?(row)
      raise Errors::Board::LocationError unless (0..8).include?(col)
      raise Errors::Board::CellTypeError unless cell.is_a?(Cell)

      @cells[row][col] = cell
    end

    def find_cell(cell)
      raise Errors::Board::CellTypeError unless cell.is_a?(Cell)

      (0..8).each do |row|
        (0..8).each do |col|
          return [row, col] if self[row, col] == cell
        end
      end

      raise Errors::Board::CellNotFoundError
    end
  end
end
