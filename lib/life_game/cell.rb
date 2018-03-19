class Cell
  module State
    DEAD  = 0
    ALIVE = 1
  end

  attr_accessor :x, :y, :state
  def initialize(x, y, alive = false)
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
      return "x"
    elsif dead?
      return " "
    end
  end

# 誕生: 死亡しているセルの周囲に生存しているセルが3つある場合、そのセルは生存する
# 生存: 生存しているセルの周囲に生存してるセルが2 or 3ある場合、そのセルは生存する
# 過疎: 生存しているセルの周囲に生存してるセルが1つ以下である場合、そのセルは死亡する
# 過密: 生存しているセルの周囲に生存しているセルが4つ以上である場合、そのセルは死亡する
  def next_state_is_alive?(surround_alive_num)
    if alive?
      return true if [2, 3].include?(surround_alive_num)
    elsif dead?
      return true if [3].include?(surround_alive_num)
    end
    false
  end
end
