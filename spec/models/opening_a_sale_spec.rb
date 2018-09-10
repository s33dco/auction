require 'rails_helper'

RSpec.describe "opening a sale" do

	let(:house){create(:house)}
	let(:sale){create(:sale, notch:5, minfee:5, house_id:house.id)}
	let(:lot){create(:lot, reserve:10, sale_id:sale.id)}
	let(:lot2){create(:lot, reserve:10, sale_id:sale.id)}
	let(:lot3){create(:lot, reserve:10, sale_id:sale.id)}

	before(:example) do
	  sale.activate
	end

	it 'marks sale complete as true' do
		expect(sale.complete).to eq(false)
	end

	it 'marks sale active as true' do
		expect(sale.active).to eq(true)
	end

end