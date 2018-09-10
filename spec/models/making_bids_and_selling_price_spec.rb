require 'rails_helper'

RSpec.describe "making bids and lot selling_price" do

	let(:buyer){create(:buyer)}
	let(:buyer2){create(:buyer)}
	let(:buyer3){create(:buyer)}
	let(:sale){create(:sale)}
	let(:lot){create(:lot)}

	before(:example) do
	  sale.update(active:true,notch:5)
	  lot.update(sale_id: sale.id, reserve:10)
	  buyer.houses << sale.house
	  buyer2.houses << sale.house
	  buyer3.houses << sale.house
	end

	it 'rejects a negative bid' do
		bid = Bid.new(lot_id:lot.id,sale_id:sale.id)
		bid.update(bidvalue:-10, buyer_id:buyer.id)
		expect(bid.errors[:bidvalue].any?).to eq(true)
	end

	it 'rejects a zero value bid' do
		bid = Bid.new(lot_id:lot.id,sale_id:sale.id)
		bid.update(bidvalue: 0, buyer_id:buyer.id)
		expect(bid.errors[:bidvalue].any?).to eq(true)
	end

	it 'will accept an initial bid below the reserve of the lot and return a selling_price of the notch + bid' do
		bid = Bid.new(lot_id:lot.id,sale_id:sale.id)
		bid.update(bidvalue: 1, buyer_id:buyer.id)
		expect(lot.selling_price).to eq(6)
	end

	it 'will accept an initial bid equal to the reserve of the lot and return a selling_price of the notch + reserve' do
		bid = Bid.new(lot_id:lot.id,sale_id:sale.id)
		bid.update(bidvalue: 10, buyer_id:buyer.id)
		expect(lot.selling_price).to eq(15)
	end

	it 'will accept an initial bid greater to the reserve of the lot and return a selling_price of the notch + reserve' do
		bid = Bid.new(lot_id:lot.id,sale_id:sale.id)
		bid.update(bidvalue: 15, buyer_id:buyer.id)
		expect(lot.selling_price).to eq(15)
	end

	it 'no bids value can be identical for the same lot' do
		bid = Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 15, buyer_id:buyer.id)
		bid2 = Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 15, buyer_id:buyer2.id)
		expect(bid2.errors[:bidvalue].any?).to eq(true)
	end

	it 'will except a second bid if equal than current selling_price' do
		bid = Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 11, buyer_id:buyer.id)
		bid2 = Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 15, buyer_id:buyer2.id)
		expect(bid2.errors[:bidvalue].any?).to eq(false)
	end

	it 'will reject a second bid if lower than current selling_price' do
		bid = Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 11, buyer_id:buyer.id)
		bid2 = Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 13, buyer_id:buyer2.id)
		expect(bid2.errors[:bidvalue].any?).to eq(true)
	end

	it 'will except a second bid if higher than current selling_price' do
		bid = Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 11, buyer_id:buyer.id)
		bid2 = Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 20, buyer_id:buyer2.id)
		expect(bid2.errors[:bidvalue].any?).to eq(false)
	end

	it 'a higher bid from the same bidder will not change the selling_price' do
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 15, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 45, buyer_id:buyer.id)
		expect(lot.selling_price).to eq(15)
	end

	it 'multiple higher bids from the same bidder will not change the selling_price' do
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 15, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 25, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 45, buyer_id:buyer.id)
		expect(lot.selling_price).to eq(15)
	end

	it 'selling_price equals second best bid plus notch when more than one buyer bidding' do
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 15, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 20, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 45, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 30, buyer_id:buyer2.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 42, buyer_id:buyer3.id)
		expect(lot.selling_price).to eq(47)
	end

	it 'selling_price equals second best bid plus notch when more than one buyer bidding' do
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 15, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 20, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 45, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 30, buyer_id:buyer2.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 39, buyer_id:buyer3.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 49, buyer_id:buyer3.id)
		Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 50, buyer_id:buyer2.id)
		expect(lot.selling_price).to eq(54)
	end
end
