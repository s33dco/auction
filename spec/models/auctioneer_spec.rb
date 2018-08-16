require 'rails_helper'

RSpec.describe Auctioneer do
  let(:auctioneer){build_stubbed(:auctioneer)}

	it "is valid with example attributes" do
    expect(auctioneer.valid?).to eq(true)
  end

  it "requires a name" do
    auctioneer.name = ""
    auctioneer.valid?
    expect(auctioneer.errors[:name].any?).to eq(true)
  end

  it "requires a email" do
    auctioneer.email = ""
    auctioneer.valid?
    expect(auctioneer.errors[:email].any?).to eq(true)
  end

end
