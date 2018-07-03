class SalesController < ApplicationController

		def index
			@sales = Sale.latest
		end

		def show
			@sale = Sale.find(params[:id])
			@lots = @sale.lots.by_lot_number
		end

		def new
			@sale = Sale.new
		end

		def create
			@sale = Sale.new(sale_params)
			if @sale.save
			  redirect_to @sale, notice: "Sale successfully created!"
			else
			  render :new
			end
		end

		def edit
			@sale = Sale.find(params[:id])
			@lots = @sale.lots.by_lot_number
		end

		def update
			@sale = Sale.find(params[:id])
			if @sale.update(sale_params)
			  redirect_to @sale, notice: "Sale successfully updated!"
			else
			  render :edit
			end
		end

		def destroy
			@sale = Sale.find(params[:id])
			@sale.destroy
	    redirect_to sales_url, alert: "Sale successfully deleted!"
		end

		private

		def sale_params
			params.require(:sale).permit(:date, :house_id)
		end
end
