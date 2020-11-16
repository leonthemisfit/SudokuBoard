# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'sudoku_board'
  s.version = '0.0.5'
  s.license = 'MIT'
  s.summary = 'A library for representing and serializing Sudoku boards'
  s.author = 'leonthemisfit'
  s.email = 'leonthemisfit@gmail.com'
  s.files = [
    'lib/board_serial.rb',
    'lib/board_static.rb',
    'lib/board.rb',
    'lib/cell.rb',
    'lib/constants.rb',
    'lib/errors.rb',
    'lib/sudoku_board.rb',
    'lib/board_validate.rb'
  ]
end
