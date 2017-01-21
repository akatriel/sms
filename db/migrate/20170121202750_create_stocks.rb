class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :company
      t.string :exchange
      t.datetime :latestDate
      t.decimal :previousOpen
      t.decimal :previousClose
      t.decimal :previousHigh
      t.decimal :previousLow
      t.string :marketCap
      t.integer :volume

      t.timestamps
    end
  end
end
