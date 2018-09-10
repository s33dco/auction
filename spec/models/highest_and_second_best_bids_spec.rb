require 'rails_helper'


RSpec.describe 'highest and second best bids' do

	let(:house){create(:house)}
	let(:sale){create(:sale, house_id:house.id, notch:5)}
	let(:buyer1){create(:buyer)}
	let(:buyer2){create(:buyer)}
	let(:buyer3){create(:buyer)}
	let(:buyer4){create(:buyer)}
	let(:lot){create(:lot, sale_id:house.id,reserve:10)}

	before(:example) do
	  buyer1.houses << sale.house
	  buyer2.houses << sale.house
	  buyer3.houses << sale.house
	  buyer4.houses << sale.house
	end

	it 'knows if only one bidder' do
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 9, buyer_id:buyer1.id)
		expect(lot.second_best_bid).to eq(nil)
	end

	it 'knows if > one bidder' do
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 9, buyer_id:buyer1.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 19, buyer_id:buyer2.id)
		expect(lot.second_best_bid).not_to eq(nil)
	end

	it 'highest bid value from 2nd bidder' do
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 9, buyer_id:buyer1.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 19, buyer_id:buyer2.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 29, buyer_id:buyer3.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 39, buyer_id:buyer4.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 59, buyer_id:buyer1.id)
		expect(lot.second_best_bid.bidvalue).to eq(39)
	end

	it 'returns 0 value when no bids as highest bid' do
		expect(lot.highest_bid_value).to eq(0)
	end

	it 'knows the highest bid value' do
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 9, buyer_id:buyer1.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 19, buyer_id:buyer2.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 29, buyer_id:buyer3.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 39, buyer_id:buyer4.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 59, buyer_id:buyer1.id)
		expect(lot.highest_bid_value).to eq(59)
	end
end
