class DropUserCardSets < ActiveRecord::Migration
  def up
    drop_table :user_card_sets
  end

  def down
    create_table :user_card_sets do |t|
      t.integer :user_id
      t.integer :card_set_id

      t.timestamps
    end
  end
end
