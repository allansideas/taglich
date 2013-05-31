class DropCardSteps < ActiveRecord::Migration
  def up
    drop_table :card_steps
  end

  def down
    create_table :card_steps do |t|
      t.integer :card_id
      t.text :content

      t.timestamps
    end
  end
end
