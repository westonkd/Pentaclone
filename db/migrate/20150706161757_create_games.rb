class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_one
      t.integer :player_two
      t.timestamps null: false
    end
  end
end
