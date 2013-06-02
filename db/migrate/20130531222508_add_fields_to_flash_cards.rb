class AddFieldsToFlashCards < ActiveRecord::Migration
  def change
    add_column :cards, :front, :text
    add_column :cards, :back, :text
    add_column :cards, :seen_times, :integer
    add_column :cards, :correct_count, :integer
    add_column :cards, :incorrect_count, :integer
    add_column :cards, :last_seen_at, :datetime
    add_column :cards, :last_interacted_at, :datetime
    add_column :cards, :card_symbols, :string
  end
end
