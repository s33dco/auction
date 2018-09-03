require 'rails_helper'

RSpec.describe Seller, type: :model do
	  let(:seller){build_stubbed(:seller)}

		it "is valid with example attributes" do
	    expect(seller.valid?).to eq(true)
	  end

	  it "requires a email" do
	    seller.email = ""
	    seller.valid?
	    expect(seller.errors[:email].any?).to eq(true)
	  end

	  it "needs atleast one character firstname" do
	    seller.firstname = ""
	    seller.valid?
	    expect(seller.errors[:firstname].any?).to eq(true)
	  end

	  it "needs atleast one character lastname" do
	    seller.lastname = ""
	    seller.valid?
	    expect(seller.errors[:lastname].any?).to eq(true)
	  end

	  it "requires a commision rate to be present" do
	    seller.commrate = ""
	    seller.valid?
	    expect(seller.errors[:commrate].any?).to eq(true)
	  end
end
