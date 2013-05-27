class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :card_set_id

      t.timestamps
    end
  end
end
