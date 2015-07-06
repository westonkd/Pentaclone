class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.text :board_state
      t.timestamps null: false
    end
  end
end
