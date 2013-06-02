class ChangeCardSetsRelationships < ActiveRecord::Migration
  def change
    add_column :card_sets, :user_id, :integer
  end
end
