class CreateCardSteps < ActiveRecord::Migration
  def change
    create_table :card_steps do |t|
      t.integer :card_id
      t.text :content

      t.timestamps
    end
  end
end
