require 'json'

class Player < ActiveRecord::Base
  belongs_to :game

  def serializable_hash(data)
    player = {}
    player['id'] = self.id
    player['name'] = self.name

    player
  end
end
