class Board < ActiveRecord::Base
  belongs_to :game
  serialize :board_state, Array

  def rotate(quad)
    quad
  end

  def win?(val)
    win_val = val.to_s
    4.times {win_val << val.to_s}

    pos_main_diag, pos_top_diag, pos_bottom_diag = [], [], []
    neg_main_diag, neg_top_diag, neg_bottom_diag = [], [], []

    for r in 0..5
      return true if board_state[r].join('').include? win_val

      current_row = []

      pos_main_diag << board_state[r][5 - r]
      pos_top_diag << board_state[r][4 - r]
      pos_bottom_diag << board_state[r][6 - r] if r != 0

      neg_main_diag << board_state[r][r]
      neg_top_diag << board_state[r][r - 1]
      neg_bottom_diag << board_state[r][r + 1] if r != 5

      for c in 0..5
        current_row << board_state[c][r]
      end

      return true if current_row.join('').include? win_val
    end

    return true if pos_main_diag.join('').include?(win_val) || pos_top_diag.join('').include?(win_val) ||
        pos_bottom_diag.join('').include?(win_val)

    return true if neg_main_diag.join('').include?(win_val) || neg_top_diag.join('').include?(win_val) ||
        neg_bottom_diag.join('').include?(win_val)

    return false
  end

  def out
    puts "  A B C D E F"
    for r in 0..5
      print "#{r} "
      for c in 0..5
        print "#{board_state[c][r] ? board_state[c][r] : 0} "
      end
      print "\n"
    end
  end

  def set(x, y, val)
    if (0..5).include?(x) && (0..5).include?(y)
      board_state[x][y] = val
      self.save
    end
  end

  def get(x,y)
    if (0..5).include?(x) && (0..5).include?(y)
      board_state[x][y]
    end
  end
end
