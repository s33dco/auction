require 'rails_helper'

RSpec.describe Sale, type: :model do
  let(:sale){build_stubbed(:sale)}

	it "is valid with example attributes" do
    expect(sale.valid?).to eq(true)
  end

  it "requires a min fee" do
    sale.minfee = ""
    sale.valid?
    expect(sale.errors[:minfee].any?).to eq(true)
  end

  it "requires a notch" do
    sale.notch = ""
    sale.valid?
    expect(sale.errors[:notch].any?).to eq(true)
  end

  it "requires a date" do
    sale.date = ""
    sale.valid?
    expect(sale.errors[:date].any?).to eq(true)
  end

  it "shows active as false" do
    expect(sale.active).to eq(false)
  end

  it "shows complete as false" do
    expect(sale.complete).to eq(false)
  end
end
