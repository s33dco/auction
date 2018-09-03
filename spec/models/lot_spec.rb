require 'rails_helper'

RSpec.describe Lot, type: :model do
  let(:lot){build_stubbed(:lot)}

	it "is valid with example attributes" do
    expect(lot.valid?).to eq(true)
  end

  it "requires a reserve of 0 or above" do
		res = [-1, '' ]
		res.each do |r|
	    lot.reserve = r
	    lot.valid?
	    expect(lot.errors[:reserve].any?).to eq(true)
	  end
  end

  it "requires a lotnumber" do
    lot.lotnumber = ""
    lot.valid?
    expect(lot.errors[:lotnumber].any?).to eq(true)
  end
end
