module LifeGame
  class Board
    attr_accessor :w, :h, :cells
    def initialize(w, h, default = {})
      @w = w
      @h = h
      @cells = initialize_cells(default[:pattern])
    end

    def finish?
      cells.all?(&:dead?)
    end

    def initialize_cells(default_pattern = [])
      default_pattern = Array.new(w * h) { false } if default_pattern.nil? || default_pattern.empty?
      Array.new(w * h) do |i|
        x = i % w
        y = i / w
        Cell.new(x, y, default_pattern[i])
      end
    end

    def get_cell(x, y)
      return nil if out_of_board(x, y)
      cells[coordinate_to_index(x, y)]
    end

    def out_of_board(x, y)
      return true if x < 0 || y < 0
      return true if w < x || h < y
      false
    end

    def surround(cell)
      result = []
      x = cell.x
      y = cell.y
      result << get_cell(x - 1, y - 1)
      result << get_cell(x,     y - 1)
      result << get_cell(x + 1, y - 1)
      result << get_cell(x - 1, y)
      result << get_cell(x + 1, y)
      result << get_cell(x - 1, y + 1)
      result << get_cell(x,     y + 1)
      result << get_cell(x + 1, y + 1)
      result.flatten.compact
    end

    def surround_alive(cell)
      surround(cell).count { |c| c&.alive? }
    end

    def coordinate_to_index(x, y)
      y * w + x
    end

    def display
      cells.map(&:show).join
    end

    def step
      new_cells = initialize_cells
      cells.each_with_index do |cell, i|
        new_cells[i].state = if cell.next_state_is_alive?(surround_alive(cell))
                               Cell::State::ALIVE
                             else
                               Cell::State::DEAD
                             end
      end
      self.cells = new_cells
    end
  end
end
