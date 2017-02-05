class AssetsController < ApplicationController
	def setAsset
		asset = Asset.find params[:asset_id]
		high = params[:high].nil? ? nil : params[:high]
		low = params[:low].nil? ? nil : params[:low]

		unless params[:start_time].empty? and params[:finish_time].empty?
			start_time = params[:start_time].to_time
			start_time = start_time.in_time_zone('Eastern Time (US & Canada)')
			finish_time = params[:finish_time].to_time
			finish_time = finish_time.in_time_zone('Eastern Time (US & Canada)')
			if (finish_time <=> start_time) <= 0
				finish_time = finish_time + 1.day
			end
		end

		

		respond_to do |format|
			if finish_time.nil? || start_time.nil?
				# TODO display flash message and display it within modal instead of rendering page again.
				flash.now[:alert] = "Could not set alert. Check start and finish times."
				format.html {render stock_path asset.stock_id}
			end
			if (asset.update_attributes high: high, low:low, start_time: start_time, finish_time: finish_time)
				flash.now[:notice] = "Alert Has Been Set" #not showing
				format.js{ render file: 'assets/_set_asset_success.js.erb'}
			end
		end
	end

	def setPayload
		asset = Asset.find params[:id]
		assHash = {}
		unless params[:payload].nil?
			if asset.payload.nil?
				payload = Payload.create asset_id: asset.id
			end

			if payload.nil?
				payload = asset.payload
			end

			payload.attributes.each do |k,v|
				if params[:payload].include? k
					if v == true
						assHash[k] = false
					else
						assHash[k] = true
					end
				end
			end
		end
		respond_to do |format|
			if payload.update_attributes assHash
				flash.now[:notice] = "Payload Customized" #not showing
				format.js{ render file: 'assets/_payload_customized.js.erb'}
			end
		end
	end
end

