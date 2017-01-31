class AddTimesToAssets < ActiveRecord::Migration[5.0]
  def change
  	add_column :assets, :start_time, :datetime
  	add_column :assets, :finish_time, :datetime
  end
end
