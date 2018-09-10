require "rails_helper"

RSpec.describe 'Logged in as Buyer' do

  let(:sale){create(:sale, active:true)}
  let(:sale2){create(:sale, active:true)}
  let(:house){create(:house)}
  let(:house2){create(:house)}
  let(:lot){create(:lot)}
  let(:buyer){create(:buyer)}
  let(:buyer2){create(:buyer)}
  let(:seller){create(:seller)}
  let(:auctioneer){create(:auctioneer)}

  before(:example) do
    sale.update(house: house)
    sale2.update(house: house2)
    buyer.houses = []
    buyer.houses << house
    buyer2.houses = []
    buyer2.houses << house2
    sign_in(buyer)
  end

  it "can view index" do
    get welcome_path
    expect(response).to have_http_status(:success)
  end

  it "cannot view buyer log in" do
    get new_buyer_session_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view seller log in" do
    get new_seller_session_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view auctioneer log in" do
    get new_auctioneer_session_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view buyer index" do
    get buyers_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view seller index" do
    get sellers_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view auctioneer index" do
    get auctioneers_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view sales index" do
    get sales_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view lots index" do
    get lots_path
    expect(response).to have_http_status(:redirect)
  end

  it "can view buyer show" do
    get buyer_path(buyer)
    expect(response).to have_http_status(:success)
  end

  it "cannot view a different buyer's show" do
    get buyer_path(buyer2)
    expect(response).to have_http_status(:redirect)
  end  

  it "cannot view seller's own show page" do
    get seller_path(seller)
    expect(response).to have_http_status(:redirect)
  end

  it "can view own bidding card for permitted active sale" do
    get buyer_bidding_path(buyer,sale)
    expect(response).to have_http_status(:success)
  end

  it "cannot view own bidding card for not permitted active sale" do
    get buyer_bidding_path(buyer,sale2)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view other buyers bidding card for permitted active sale" do
    get buyer_bidding_path(buyer2,sale2)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view own bidding card for permitted non active sale" do
    sale.active = false
    sale.save
    get buyer_bidding_path(buyer,sale)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view own bidding card for complete sale" do
    sale.active = false
    sale.complete = true
    sale.save
    get buyer_bidding_path(buyer,sale)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot view other buyers bidding card for complete sale" do
    sale2.active = false
    sale2.complete = true
    sale2.save
    get buyer_bidding_path(buyer,sale2)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot create a sale" do
    get new_sale_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot create a seller" do
    get new_seller_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot create a buyer" do
    get new_buyer_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot create an auctioneer" do
    get new_auctioneer_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot edit an auctioneer" do
    get edit_auctioneer_path(auctioneer)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot edit a buyer" do
    get edit_buyer_path(buyer)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot edit a seller" do
    get edit_seller_path(seller)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot edit a sale" do
    get edit_sale_path(sale)
    expect(response).to have_http_status(:redirect)
  end

  it "cannoy edit a lot" do
    get edit_lot_path(lot)
    expect(response).to have_http_status(:redirect)
  end
end