class AddUserIdToMetrics < ActiveRecord::Migration
  def change
    add_column :metrics, :user_id, :integer
  end
end
