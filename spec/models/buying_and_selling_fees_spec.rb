require 'rails_helper'


RSpec.describe 'buying and selling fees' do

	let(:house){create(:house)}
	let(:sale){create(:sale, house_id:house.id, minfee:10)}
	let(:buyer1){create(:buyer, commrate:10)}
	let(:seller1){create(:seller, commrate:10)}
	let(:lot){create(:lot, sale_id:sale.id,reserve:10,seller_id:seller1.id)}
	
	it 'return minfee when buying comm is less' do
		Bid.create(lot_id:lot.id,sale_id:sale.id, bidvalue: 500, buyer_id:buyer1.id)
		allow(lot).to receive(:selling_price).and_return(50)
		expect(lot.buyingfee).to eq(10)
	end

	it 'return % comm when is more' do
		Bid.create(lot_id:lot.id,sale_id:sale.id, bidvalue: 500, buyer_id:buyer1.id)
		allow(lot).to receive(:selling_price).and_return(500)
		expect(lot.buyingfee).to eq(50)
	end

	it 'return minfee when selling comm is less' do
		Bid.create(lot_id:lot.id,sale_id:sale.id, bidvalue: 500, buyer_id:buyer1.id)
		allow(lot).to receive(:selling_price).and_return(50)
		expect(lot.sellingfee).to eq(10)
	end

	it 'return % selling comm when is more' do
		Bid.create(lot_id:lot.id,sale_id:sale.id, bidvalue: 500, buyer_id:buyer1.id)
		allow(lot).to receive(:selling_price).and_return(500)
		expect(lot.sellingfee).to eq(50)
	end

end