require 'pp'
require 'pry'
require './lib/life_game/board'
require './lib/life_game/cell'
require './lib/life_game/window_manager'

module LifeGame
  def self.run(x, y, opt)
    begin
      b = Board.new(x, y, opt)
      win = WindowManager.new(x, y)
      10.times do
        win.exec(b.display)
        b.step
        sleep(0.2)
      end
    ensure
      win.close
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
