class AssetsController < ApplicationController
	def setAsset
		asset = Asset.find params[:asset_id]
		high = params[:high].nil? ? nil : params[:high]
		low = params[:low].nil? ? nil : params[:low]
		start_time = make_time params[:asset]["start_time(4i)"], params[:asset]["start_time(5i)"]
		finish_time = make_time params[:asset]["finish_time(4i)"], params[:asset]["finish_time(5i)"]

		respond_to do |format|
			if asset.update_attributes high: high, low:low, start_time: start_time, finish_time: finish_time
				flash.now[:notice] = "Alert Has Been Set"
				format.js{ render file: 'assets/_set_asset_success.js.erb'}
			end
		end
	end

	private 
	def make_time hour, minute
		time = hour << ":" << minute
		time.to_time.in_time_zone('Eastern Time (US & Canada)')
	end
end

