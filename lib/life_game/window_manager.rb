require "curses"

module LifeGame
  class WindowManager
    attr_accessor :win, :w, :h
    def initialize(width, height)
      Curses.init_screen
      Curses.curs_set(0)
      top  = (Curses.lines - height) / 2
      left = (Curses.cols - width) / 2
      @w   = width
      @h   = height
      @win = Curses::Window.new(height + 2, width + 2, top, left)
    end

    def exec(data)
      win.clear
      win.box("|","-","*")
      h.times.each do |i|
        win.setpos(i + 1, 1)
        win.addstr(data[(h*i)...(h*i+w)])
      end
      win.refresh
    end

    def close
      win.close
      Curses.close_screen
    end
  end
end

# win = LifeGame::WindowManager.new(8, 8)
# win.exec(64.times.map { |i|(40+i).chr }.join)
# sleep(50)
# win.close
