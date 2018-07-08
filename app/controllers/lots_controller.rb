class LotsController < ApplicationController

	def show
		@lot = Lot.find(params[:id])
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
		params.require(:lot).permit(:_destroy, :category_id, :seller_id, :manufacturer, :model, :description, :lotnumber, :reserve, :sale_id)
	end
end
