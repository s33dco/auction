class SalesController < ApplicationController

	before_action :someone_signed_in, only: [:show]
	before_action :check_if_admin, except:[:show]

		def index
			@sales  = Sale.send(sales_scope).page(params[:page]).per(20)
			@building = @sales.building
			@live_sales = @sales.live
			@complete_sales = @sales.ended
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
			  redirect_to @sale, notice: "#{@sale.house.name} #{nice_date(@sale.date)} created!"
			else
			  render :new
			end
		end

		def edit
			@sale = Sale.find(params[:id])
		end

		def update
			@sale = Sale.find(params[:id])
			if @sale.update(sale_params)
			  redirect_to @sale, notice: "#{@sale.house.name} #{nice_date(@sale.date)} updated!"
			else
			  render :edit
			end
		end

		def destroy
			@sale = Sale.find(params[:id])
			if @sale.bids.empty?
				@sale.destroy
		    redirect_to sales_url, alert: "#{@sale.house.name} #{nice_date(@sale.date)} and all lots deleted!"
		  else
		  	redirect_to @sale, alert: "#{@sale.house.name} #{nice_date(@sale.date)} cannot be deleted as bids have been made!"
		  end
		end

		def activate
			@sale = Sale.find(params[:id])
		  flash[:notice] = "It's on - #{@sale.house.name} #{nice_date(@sale.date)} Active - no changes can be made." if @sale.activate
		  redirect_to sales_url
		end

		def deactivate
			@sale = Sale.find(params[:id])
		  flash.now[:notice] = "#{@sale.house.name} #{nice_date(@sale.date)} building report..." if @sale.deactivate
		  @sale.generate_report
		  flash[:notice] = "#{@sale.house.name} #{nice_date(@sale.date)} now closed - report built."
		  redirect_to sales_url
		end


		private

		def sales_scope
		  if params[:scope].in? %w(ended building live)
		    params[:scope]
		  else
		    :live
		  end
		end

		def set_sale
			@sale = Sale.find(params[:id])
		end

		def sale_params
			params.require(:sale).permit(:notch, :minfee, :date, :house_id,
			lots_attributes:[ :id, :_destroy, :category_id, :seller_id, :manufacturer, :model, :description, :lotnumber, :reserve, :image, pictures:[] ])
		end
end
