require 'rails_helper'

RSpec.describe "resetting a lot" do

	let(:buyer){build_stubbed(:buyer)}
	let(:house){create(:house)}
	let(:sale){create(:sale, house_id:house.id, notch:5)}
	let(:category){create(:category)}
	let(:lot){create(:lot, sale_id:sale.id, category_id:category.id, soldat: 100, bfee: 10, sfee: 10, sold: true, buyerpaid: false, sellerpaid: false, buyer_id: buyer.id )}

	before(:example) do
		buyer.houses << sale.house
		Bid.create(lot_id:lot.id, bidvalue:40, sale_id:sale.id, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id, bidvalue:60, sale_id:sale.id, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id, bidvalue:80, sale_id:sale.id, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id, bidvalue:100, sale_id:sale.id, buyer_id:buyer.id)
		Bid.create(lot_id:lot.id, bidvalue:110, sale_id:sale.id, buyer_id:buyer.id)
		lot.reset
	end

	it 'does not change the sale id' do
		expect(lot.sale_id).to eq(1)
	end

	it 'resets the soldat price to nil' do
		expect(lot.soldat).to be(nil)
	end

	it 'resets the buyerfee to nil' do
		expect(lot.bfee).to be(nil)
	end

	it 'resets the buyer_id to nil' do
		expect(lot.buyer_id).to be(nil)
	end

	it 'resets the sellerfee to nil' do
		expect(lot.sfee).to be(nil)
	end

	it 'resets buyerpaid to nil' do
		expect(lot.buyerpaid).to be(nil)
	end

	it 'resets sellerpaid to nil' do
		expect(lot.sellerpaid).to be(nil)
	end

	it 'resets sold to nil' do
		expect(lot.sold).to be(nil)
	end
end
