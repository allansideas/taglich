class CreateUserCardSets < ActiveRecord::Migration
  def change
    create_table :user_card_sets do |t|
      t.integer :user_id
      t.integer :card_set_id

      t.timestamps
    end
  end
end
