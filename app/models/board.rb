class Board < ActiveRecord::Base
  belongs_to :game
  serialize :board_state, Array
end
