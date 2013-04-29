class RemoveScoreFromMetrics < ActiveRecord::Migration
  def change
    remove_column :metrics, :score
  end
end
