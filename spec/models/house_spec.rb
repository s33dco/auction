require 'rails_helper'

RSpec.describe House do

  let(:house){build_stubbed(:house)}

	it "is valid with example attributes" do
    expect(house.valid?).to eq(true)
  end

  it "requires a name" do
    house.name = ""
    house.valid?
    expect(house.errors[:name].any?).to eq(true)
  end

  it "requires a phone number" do
    house.phone = ""
    house.valid?
    expect(house.errors[:phone].any?).to eq(true)
  end

  it "requires a code" do
    house.code = ""
    house.valid?
    expect(house.errors[:code].any?).to eq(true)
  end
end
