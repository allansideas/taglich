class AddSortOrderToMetrics < ActiveRecord::Migration
  def change
    add_column :metrics, :sort_order, :integer
  end
end
