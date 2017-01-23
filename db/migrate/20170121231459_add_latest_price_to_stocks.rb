class AddLatestPriceToStocks < ActiveRecord::Migration[5.0]
  def change
  	add_column :stocks, :latestPrice, :decimal
  end
end
