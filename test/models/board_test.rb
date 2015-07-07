require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  def new_board
    Board.new(board_state: Array.new(6){Array.new(6){0}})
  end

  def col_win(val)
    b = new_board
    val = val.to_s

    b.board_state[2] = [val, val, val, val, val, val]

    b
  end

  def row_win(val)
    b = new_board

    for i in 0..4
      b.set(i, 1, val)
    end

    b
  end

  def pos_main_win(val)
    b = new_board

    for i in 1..5
      b.set(i, 5 - i, val)
    end
    b.out
    b
  end

  def pos_top_win(val)
    b = new_board

    for i in 0..5
      b.set(i, 4 - i, val)
    end
    b.out
    b
  end

  def pos_bottom_win(val)
    b = new_board

    for i in 1..5
      b.set(i, 6 - i, val)
    end

    b.out
    b
  end

  def neg_main_win(val)
    b = new_board

    for i in 0..4
      b.set(i, i, val)
    end

    b.out
    b
  end

  def neg_top_win(val)
    b = new_board

    for i in 0..5
      b.set(i, i - 1, val)
    end

    b.out
    b
  end

  def neg_bottom_win(val)
    b = new_board

    for i in 0..4
      b.set(i, i + 1, val)
    end
    b.out
    b
  end

  test "finds wins in columns" do
    assert col_win(1).win?(1), 'Column win check failed for player 1'
    assert col_win(2).win?(2), 'Column win check failed for player 2'
  end

  test "finds wins in rows" do
    assert row_win(1).win?(1), 'Row win check failed for player 1'
    assert row_win(2).win?(2), 'Row win check failed for player 2'
  end

  test "finds wins on positive slopes" do
    assert pos_bottom_win(1).win?(1), 'Pos bottom diag win check failed player 1'
    assert pos_main_win(1).win?(1), 'Pos main diag win check failed player 1'
    assert pos_top_win(1).win?(1), 'Pos top diag win check failed player 1'
  end

  test "finds wind on negative slopes" do
    assert neg_main_win(1).win?(1), 'Neg main diag win check failed player 1'
    assert neg_top_win(1).win?(1), 'Neg top diag win check failed player 1'
    assert neg_bottom_win(1).win?(1), 'Neg bottom diag win check failed player 1'
  end
end
