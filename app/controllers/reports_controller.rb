class ReportsController < ApplicationController
	def index
	end

	def viewer
		@sale = Sale.find(params[:report][:sale_id])
		@sale_lots = @sale.lots.by_lot_number
		buyer = params[:report][:buyer_id]
		seller = params[:report][:seller_id]

		if buyer.blank? && seller.blank?
			@lots = @sale.lots.by_lot_number
			@sold_lots = @lots.map{|l| l.sold == true}
		elsif !buyer.blank?
			@buyer = Buyer.find(params[:report][:buyer_id])
			@buyer_lots = @buyer.winning_bids_in(@sale).map { |b| b.lot  }.sort{|b,a| b.lotnumber <=> a.lotnumber}
			@buyer_bill = @buyer_lots.sum{|l| l.soldat + l.bfee}
		else !seller.blank?
			@seller = Seller.find(params[:report][:seller_id])
			@seller_lots = @seller.lots.select{| l | l.sale_id == @sale.id}
			@seller_sold_lots = @seller_lots.select{|l| l.sold == true}.sort{|b,a| b.lotnumber <=> a.lotnumber}
			@seller_payment = @seller_sold_lots.sum{|l| l.soldat - l.sfee}
			@seller_unsold_lots = @seller_lots.select{|l| l.sold == false}.sort{|b,a| b.lotnumber <=> a.lotnumber}
		end
	end

	private

	def report_params
		params.require(:report).permit(:buyer_id, :seller_id, :sale_id)
	end
end
