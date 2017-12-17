class CreateTenures < ActiveRecord::Migration[5.1]
  def change
    create_table :tenures do |t|
      t.integer :month
      t.integer :rate
      t.integer :minimum_amount
      t.references :bank, foreign_key: true

      t.timestamps
    end
  end
end
