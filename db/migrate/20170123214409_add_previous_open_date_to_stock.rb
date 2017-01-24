class AddPreviousOpenDateToStock < ActiveRecord::Migration[5.0]
  def change
  	add_column :stocks, :previousOpenDate, :datetime
  end
end
