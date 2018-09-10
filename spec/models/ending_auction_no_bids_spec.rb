require 'rails_helper'

RSpec.describe 'end auction write to lots' do

	let!(:house){create(:house)}
	let!(:category){create(:category, title:'stuff', id:1)}
	let!(:sale){create(:sale, house_id:house.id, notch:5)}
	let!(:lot){create(:lot, sale_id:house.id,reserve:200)}

	before(:example) do
	  sale.activate
	  sale.deactivate
	  sale.write_auction_info_to_lots!
	end

	it 'sets lot#sold to false' do
		item = sale.lots.first
		expect(item.sold).to eq(false)
	end

	it 'sets lot#buyerpaid to nil' do
		item = sale.lots.first
		expect(item.buyerpaid).to eq(nil)
	end

	it 'sets lot#sellerpaid to nil' do
		item = sale.lots.first
		expect(item.sellerpaid).to eq(nil)
	end

	it 'sets lot#bfee to zero' do
		item = sale.lots.first
		expect(item.bfee).to eq(0)
	end

	it 'sets lot#sfee to zero' do
		item = sale.lots.first
		expect(item.sfee).to eq(0)
	end

	it 'sets lot#soldat to zero' do
		item = sale.lots.first
		expect(item.soldat).to eq(0)
	end
end