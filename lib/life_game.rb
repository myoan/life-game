require 'pp'
require 'pry'
require './lib/life_game/board'
require './lib/life_game/cell'

module LifeGame
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

LifeGame.run(8, 8, {pattern: data})
