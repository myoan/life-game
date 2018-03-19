require './lib/life_game/board'
require './lib/life_game/cell'
require './lib/life_game/window_manager'

module LifeGame
  def self.run(x, y, opt)
    begin
      b = Board.new(x, y, opt)
      win = WindowManager.new(x, y)
      loop do
        break if b.finish?
        win.exec(b.display)
        b.step
        sleep(0.2)
      end
    ensure
      win.close
    end
  end
end

