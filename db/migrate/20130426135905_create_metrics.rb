class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.string :name
      t.integer :score
      t.string :score_type

      t.timestamps
    end
  end
end
