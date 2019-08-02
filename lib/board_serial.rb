# frozen_string_literal: true

require_relative 'errors'

module Sudoku
  module BoardSerial
    def to_raw(sep = ' ')
      rows.map { |row| row.map(&:to_s).join(sep) }.join("\n")
    end

    def serialize(serializer = :yaml)
      case serializer
      when :yaml
        YAML.dump(@cells)
      when :binary
        Marshal.dump(@cells)
      when :raw
        to_raw(' ')
      else
        raise Errors::Board::InvalidSerializerError
      end
    end

    def save(path, serializer = :yaml)
      File.open(path, 'w') { |f| f.write(serialize(serializer)) }
    end
  end
end
