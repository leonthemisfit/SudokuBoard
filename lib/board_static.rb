# frozen_string_literal: true

require 'yaml'

require_relative 'cell'
require_relative 'board'
require_relative 'errors'

module Sudoku
  module BoardStatic
    def parse_raw(lines, sep = ' ')
      raise Errors::Board::InvalidFormat unless lines.length == 9

      lines.map { |row| Board.parse_row(row, sep) }
    end

    def parse_row(row, sep)
      cells = row.split(sep)

      raise Errors::Board::InvalidFormat unless cells.length == 9

      cells.map { |cell| parse_cell(cell) }
    end

    def parse_cell(cell)
      if (1..9).include?(cell.to_i)
        Cell.new(cell.to_i, true)
      elsif cell == '*'
        Cell.new
      else
        raise Errors::Board::InvalidFormat
      end
    end

    def load_file(path, serializer = :yaml)
      serial =
        if serializer == :raw
          File.readlines(path)
        else
          File.read(path)
        end
      Board.new(serial, serializer)
    end

    def deserialize(serial, serializer)
      case serializer
      when :yaml
        # rubocop:disable Security/YAMLLoad
        YAML.load(serial)
        # rubocop:enable Security/YAMLLoad
      when :binary
        # rubocop:disable Security/MarshalLoad
        Marshal.load(serial)
        # rubocop:enable Security/MarshalLoad
      when :raw
        Board.parse_raw(serial)
      else
        raise Errors::Board::InvalidSerializerError
      end
    end
  end
end
