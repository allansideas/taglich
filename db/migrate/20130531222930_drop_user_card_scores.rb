class DropUserCardScores < ActiveRecord::Migration
  def up
    drop_table :user_card_scores
  end

  def down
    create_table :user_card_scores do |t|
      t.integer :card_id
      t.integer :user_id
      t.integer :seen_times
      t.integer :metric_1_count
      t.integer :metric_2_count
      t.date :last_seen_at
      t.date :last_interacted_at

      t.timestamps
    end
  end
end
