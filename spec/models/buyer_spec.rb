require 'rails_helper'

RSpec.describe Buyer, type: :model do
  let(:buyer){build_stubbed(:buyer)}

	it "is valid with example attributes" do
    expect(buyer.valid?).to eq(true)
  end

  it "requires a email" do
    buyer.email = ""
    buyer.valid?
    expect(buyer.errors[:email].any?).to eq(true)
  end

  it "needs atleast one character firstname" do
    buyer.firstname = ""
    buyer.valid?
    expect(buyer.errors[:firstname].any?).to eq(true)
  end

  it "needs atleast one character lastname" do
    buyer.lastname = ""
    buyer.valid?
    expect(buyer.errors[:lastname].any?).to eq(true)
  end

  it "requires a commision rate to be present" do
    buyer.commrate = ""
    buyer.valid?
    expect(buyer.errors[:commrate].any?).to eq(true)
  end
end
