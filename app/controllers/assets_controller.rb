class AssetsController < ApplicationController
	def setAsset
		asset = Asset.find params[:asset_id]
		high = params[:high].nil? ? nil : params[:high]
		low = params[:low].nil? ? nil : params[:low]
		start_time = make_time params[:asset]["start_time(4i)"], params[:asset]["start_time(5i)"]
		finish_time = make_time params[:asset]["finish_time(4i)"], params[:asset]["finish_time(5i)"]
		respond_to do |format|
			if asset.update_attributes high: high, low:low, start_time: start_time, finish_time: finish_time
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


	private 
	def make_time hour, minute
		time = hour << ":" << minute
		time.to_time.in_time_zone('Eastern Time (US & Canada)')
	end
end

