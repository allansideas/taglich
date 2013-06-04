class AddDeactivatedOnToMetrics < ActiveRecord::Migration
  def change
    add_column :metrics, :deactivated_on, :datetime
  end
end
