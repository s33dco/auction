class LotsController < ApplicationController

	def index
		@lots = Lot.send(lots_scope)
	end

	def show
		@lot = Lot.find(params[:id])
		@buyer = Buyer.first
	end

	def edit
		@lot = Lot.find(params[:id])
	end

	def update
	@lot = Lot.find(params[:id])
		if @lot.update(lot_params)
		  redirect_to @lot.sale, notice: "Lot successfully updated!"
		else
		  render :edit
		end
	end

	def destroy
		@lot = Lot.find(params[:id])
		@lot.destroy
    redirect_to sales_path, alert: "Lot successfully deleted!"
	end

	private

	def lot_params
		params.require(:lot).permit(:category_id, :seller_id, :manufacturer, :model, :description, :lotnumber, :reserve, :sale_id, :image, :pictures)
	end

	def lots_scope
	  if params[:scope].in? %w(complete active unsold sold)
	    params[:scope]
	  else
	    :sold
	  end
	end


end
