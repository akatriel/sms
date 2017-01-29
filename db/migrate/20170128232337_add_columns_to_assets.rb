class AddColumnsToAssets < ActiveRecord::Migration[5.0]
  def change
  	add_column :assets, :sent_at, :datetime
  	add_column :assets, :previous_success, :bool
  end
end
