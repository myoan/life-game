require "curses"

module LifeGame
  class WindowManager
    attr_accessor :window, :width, :height
    def initialize(width, height)
      Curses.init_screen
      Curses.curs_set(0)
      top  = (Curses.lines - height) / 2
      left = (Curses.cols - width) / 2
      @width  = width
      @height = height
      @window = Curses::Window.new(height + 2, width + 2, top, left)
    end

    def exec(data)
      window.clear
      window.box("|", "-", "*")
      height.times.each do |i|
        window.setpos(i + 1, 1)
        window.addstr(data[(height * i)...(height * i + width)])
      end
      window.refresh
    end

    def close
      window.close
      Curses.close_screen
    end
  end
end
