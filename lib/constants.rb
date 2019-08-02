# frozen_string_literal: true

module Sudoku
  module Constants
    GRID_RANGES = [
      [0..2, 0..2],
      [0..2, 3..5],
      [0..2, 6..8],

      [3..5, 0..2],
      [3..5, 3..5],
      [3..5, 6..8],

      [6..8, 0..2],
      [6..8, 3..5],
      [6..8, 6..8]
    ].freeze
  end
end
