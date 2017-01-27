class AddThresholdsToAssets < ActiveRecord::Migration[5.0]
  def change
  	add_column :assets, :high, :float
  	add_column :assets, :low, :float
  end
end
