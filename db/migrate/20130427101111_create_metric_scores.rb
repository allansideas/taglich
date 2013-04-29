class CreateMetricScores < ActiveRecord::Migration
  def change
    create_table :metric_scores do |t|
      t.references :day
      t.references :metric
      t.integer :score, :default => 0, :null => false

      t.timestamps
    end
    add_index :metric_scores, :day_id
    add_index :metric_scores, :metric_id
  end
end
