class LotsController < ApplicationController

	before_action :auctioneer_or_buyer_logged_in, only: [:show]
	before_action :check_if_admin, except:[:show]

	def index
		session[:q] = params[:q] if params[:q]
		search
		
		items if search_params

		@saved_for_csv = Lot.auctioned.search(session[:q]).result

		respond_to do |format|
			format.html
			format.csv { send_data @saved_for_csv.to_csv }
		end
		
	end

	def show
		@lot = Lot.find(params[:id])
	end

	def edit
		@lot = Lot.find(params[:id])
	end

	def update
	@lot = Lot.find(params[:id])
		if @lot.update(lot_params)
		  redirect_to lots_url notice: "Lot successfully updated!"
		else
		  render :edit
		end
	end

	def destroy
		@lot = Lot.find(params[:id])
		@lot.destroy
    redirect_to sales_path, alert: "Lot successfully deleted!"
	end

	def delete_image
		@lot = Lot.find(params[:id])
		@lot.image.purge
		redirect_to edit_sale_url(@lot.sale)
	end

	def delete_pictures
		@lot = Lot.find(params[:id])
		@lot.pictures.purge
		redirect_to edit_sale_url(@lot.sale)
	end

	def delete_one_attached_picture
		attchmnt = ActiveStorage::Attachment.find(params[:id])
		attchmnt.purge
		redirect_to request.referrer, alert: "Image deleted"
	end

	def delete_main_image
		@lot = Lot.find(params[:id])
		@lot.image.purge
		redirect_to request.referrer, alert: "Image deleted"
	end

	def reset_bids_and_fees
		@lot = Lot.find(params[:id])
		flash[:alert] = "All bids destroyed, all fees reset" if @lot.reset
		redirect_to edit_lot_url(@lot)
	end

	private

	def items
	  @lots ||= search.result
	  # add .page(params[:page]).per(20) to above to paginate...
	end 

	def search
		@search ||= Lot.all.search(search_params)
	end

	def search_params
		params[:q]
	end

	def lot_params
		params.require(:lot).permit(:sale_id, :manufacturer, :model, :description, :lotnumber, :reserve, :dispute, :category_id, :buyer_id, :seller_id, :winner, :soldat, :bfee, :sfee, :sold, :buyerpaid, :sellerpaid, :image, pictures:[])
	end
end
