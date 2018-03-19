require 'pp'
require 'pry'
# 誕生: 死亡しているセルの周囲に生存しているセルが3つある場合、そのセルは生存する
# 生存: 生存しているセルの周囲に生存してるセルが2 or 3ある場合、そのセルは生存する
# 過疎: 生存しているセルの周囲に生存してるセルが1つ以下である場合、そのセルは死亡する
# 過密: 生存しているセルの周囲に生存しているセルが4つ以上である場合、そのセルは死亡する

class Board
  attr_accessor :w, :h, :cells
  def initialize(w, h, default = {})
    @w = w
    @h = h 
    @cells = initialize_cells(default[:pattern])
  end

  def initialize_cells(default_pattern = [])
    default_pattern = Array.new(w*h) { false } if default_pattern.nil? || default_pattern.empty?
    Array.new(w * h) do |i|
      x = i % w
      y = i / w
      Cell.new(x, y, default_pattern[i])
    end
  end

  def get_cell(x, y)
    return nil if x < 0
    return nil if y < 0
    return nil if x > w
    return nil if y > h
    cells[coordinate_to_index(x, y)]
  end

  def surround(cell)
    result = []
    x = cell.x
    y = cell.y
    result << get_cell(x-1, y-1)
    result << get_cell(x,   y-1)
    result << get_cell(x+1, y-1)
    result << get_cell(x-1, y)
    result << get_cell(x+1, y)
    result << get_cell(x-1, y+1)
    result << get_cell(x,   y+1)
    result << get_cell(x+1, y+1)
    ret = result.flatten.compact
    # puts "surround: (#{cell.x}, #{cell.y}): #{cell.state}"
    # pp ret
    ret
  end

  def surround_alive(cell)
    srd = surround(cell)
    srd.count do |c|
      c&.alive?
    end
    # surround(cell).count { |c| c&.alive? }
  end

  def coordinate_to_index(x, y)
    y * w + x
  end

  def show(data = [])
    data = self.cells if data.empty?
    h.times do |y|
      print "["
      w.times { |x| data[coordinate_to_index(x, y)].show }
      puts "]"
    end
  end

  def step
    new_cells = initialize_cells
    cells.each_with_index do |cell, i|
      if cell.next_state_is_alive?(surround_alive(cell))
        new_cells[i].state = Cell::State::ALIVE
      else 
        new_cells[i].state = Cell::State::DEAD
      end
    end
    self.cells = new_cells
  end
end

class Cell
  module State
    DEAD  = 0
    ALIVE = 1
  end

  attr_accessor :x, :y, :state
  def initialize(x, y, alive = false)
    # puts "create cell at (#{x}, #{y}) alive: #{alive}"
    @x = x
    @y = y
    @state = alive ? State::ALIVE : State::DEAD
  end

  def alive?
    state == State::ALIVE
  end

  def dead?
    state == State::DEAD
  end

  def show
    if alive?
      print "x"
    elsif dead?
      print " "
    end
  end

  def next_state_is_alive?(surround_alive_num)
    if alive?
      return true if [2, 3].include?(surround_alive_num)
    elsif dead?
      return true if [3].include?(surround_alive_num)
    end
    false
  end
end

class Game
  def self.run(x, y, opt)
    b = Board.new(x, y, opt)
    10.times do
      b.show
      b.step
      puts "---"
    end
  end
end

raw_data = "        " +
           "        " +
           "        " +
           "    x   " +
           "   x    " +
           "   xxx  " +
           "        " +
           "        "

data = raw_data.split("").map { |c| next true if c == "x"; false }

Game.run(8, 8, {pattern: data})


