class AddUserIndexesToDaysMetrics < ActiveRecord::Migration
  def change
    add_index :days, :user_id
    add_index :metrics, :user_id
  end
end
