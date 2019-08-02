# frozen_string_literal: true

module Sudoku
  module Errors
    module Cell
      class ValueTypeError < TypeError
        def initialize(msg = 'Value must be of type Integer')
          super
        end
      end

      class ValueError < StandardError
        def initialize(msg = 'Value must be between 1 and 9')
          super
        end
      end

      class ConstantError < StandardError
        def initialize(msg = 'Cell is constant and cannot be set')
          super
        end
      end
    end

    module Board
      class LocationError < IndexError
        def initialize(msg = 'Board location is out of range')
          super
        end
      end

      class CellTypeError < TypeError
        def initialize(msg = 'Cell value must be of type Cell')
          super
        end
      end

      class CellNotFoundError < StandardError
        def initialize(msg = 'Specified cell not found on board')
          super
        end
      end

      class InvalidSerializerError < StandardError
        def initialize(msg = 'The specified serializer is not recognized')
          super
        end
      end

      class InvalidFormat < StandardError
        def initialize(msg = 'The input format could not be parsed')
          super
        end
      end
    end
  end
end
