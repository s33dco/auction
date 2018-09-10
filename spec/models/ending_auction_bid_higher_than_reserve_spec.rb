require 'rails_helper'

RSpec.describe 'end auction write to lots' do

	let!(:house){create(:house)}
	let!(:category){create(:category, title:'stuff', id:1)}
	let!(:sale){create(:sale, house_id:house.id, notch:5)}
	let!(:buyer1){create(:buyer)}
	let!(:buyer2){create(:buyer)}
	let!(:buyer3){create(:buyer)}
	let!(:buyer4){create(:buyer)}
	let!(:lot){create(:lot, sale_id:house.id,reserve:10)}

	before(:example) do
	  buyer1.houses << sale.house
	  buyer2.houses << sale.house
	  buyer3.houses << sale.house
	  buyer4.houses << sale.house
	  sale.activate
	  Bid.create!(lot_id:lot.id,sale_id:sale.id,bidvalue: 9, buyer_id:buyer1.id)
	  Bid.create!(lot_id:lot.id,sale_id:sale.id,bidvalue: 19, buyer_id:buyer2.id)
	  Bid.create!(lot_id:lot.id,sale_id:sale.id,bidvalue: 29, buyer_id:buyer3.id)
	  Bid.create!(lot_id:lot.id,sale_id:sale.id,bidvalue: 39, buyer_id:buyer4.id)
	  winning_bid = Bid.create!(lot_id:lot.id,sale_id:sale.id,bidvalue: 59, buyer_id:buyer1.id)
	  sale.deactivate
	  sale.write_auction_info_to_lots!
	end

	it 'sets lot#sold to true' do
		item = sale.lots.first
		expect(item.sold).to eq(true)
	end

	it 'sets lot#buyerpaid to false' do
		item = sale.lots.first
		expect(item.buyerpaid).to eq(false)
	end

	it 'ids the correct buyer' do
		item = sale.lots.first
		expect(item.buyer).to eq(buyer1)
	end

	it 'sets lot#sellerpaid to false' do
		item = sale.lots.first
		expect(item.sellerpaid).to eq(false)
	end

	it 'sets lot#soldat to 2nd highest bid plus notch' do
		item = sale.lots.first
		expect(item.soldat).to eq(44)
	end
end