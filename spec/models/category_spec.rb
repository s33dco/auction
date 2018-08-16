require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category){build_stubbed(:category)}

	it "is valid with example attributes" do
    expect(category.valid?).to eq(true)
  end

  it "requires a title" do
    category.title = ""
    category.valid?
    expect(category.errors[:title].any?).to eq(true)
  end
end
