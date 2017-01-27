class AssetsController < ApplicationController
	def setAsset
		asset = Asset.find params[:asset_id]
		high = params[:high].nil? ? nil : params[:high]
		low = params[:low].nil? ? nil : params[:low]

		respond_to do |format|
			if asset.update_attributes high: high, low:low
				flash.now[:notice] = "Alert Has Been Set"
				format.js{ render file: 'assets/_set_asset_success.js.erb'}
			end
		end
	end
end
