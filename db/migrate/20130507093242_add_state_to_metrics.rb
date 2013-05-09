class AddStateToMetrics < ActiveRecord::Migration
  def change
    add_column :metrics, :state, :string
  end
end
