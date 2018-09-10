require 'rails_helper'

RSpec.describe "closing a sale" do

	let(:house){create(:house)}
	let(:sale){create(:sale, notch:5, minfee:5, house_id:house.id)}
	let(:buyer){create(:buyer)}
	let(:buyer2){create(:buyer)}
	let(:buyer3){create(:buyer)}
	let(:lot){create(:lot, reserve:10, sale_id:sale.id)}
	let(:lot2){create(:lot, reserve:10, sale_id:sale.id)}
	let(:lot3){create(:lot, reserve:10, sale_id:sale.id)}

	before(:example) do
	  buyer.houses << sale.house
	  buyer2.houses << sale.house
	  buyer3.houses << sale.house
	  Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 15, buyer_id:buyer.id)
	  Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 20, buyer_id:buyer.id)
	  Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 45, buyer_id:buyer.id)
	  Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 30, buyer_id:buyer2.id)
	  Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 39, buyer_id:buyer3.id)
	  Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 49, buyer_id:buyer3.id)
	  Bid.create(lot_id:lot.id,sale_id:sale.id,bidvalue: 50, buyer_id:buyer2.id)
	  sale.activate
	  sale.deactivate
	  sale.write_auction_info_to_lots!
	end

	it 'marks sale complete as true' do
		expect(sale.complete).to eq(true)
	end

	it 'marks sale active as false' do
		expect(sale.active).to eq(false)
	end

end