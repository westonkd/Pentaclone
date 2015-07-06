class AddIsActiveToGames < ActiveRecord::Migration
  def change
    add_column :games, :is_active, :boolean
  end
end
