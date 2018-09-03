require 'rails_helper'

RSpec.describe Bid, type: :model do
	let!(:bid){build_stubbed(:bid)}

	it "is valid with example attributes" do
    expect(bid.valid?).to eq(true)
  end

  it "requires a buyer" do
    bid.buyer_id = ""
    bid.valid?
    expect(bid.errors[:buyer].any?).to eq(true)
  end  

  it "requires a sale" do
    bid.sale_id = ""
    bid.valid?
    expect(bid.errors[:sale].any?).to eq(true)
  end 

  it "requires a bid value" do
    bid.bidvalue = ""
    bid.valid?
    expect(bid.errors[:bidvalue].any?).to eq(true)
  end 

  it "rejects negative bid values" do
    bid.bidvalue = -1
    bid.valid?
    expect(bid.errors[:bidvalue].any?).to eq(true)
  end 
end
