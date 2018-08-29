require "rails_helper"

RSpec.describe 'Logged in as Auctioneer' do

  let(:sale){create(:sale)}
  let(:lot){create(:lot)}
  let(:seller){create(:seller)}
  let(:buyer){create(:buyer)}
  let(:auctioneer){create(:auctioneer)}

  before(:example) do
    sign_in(auctioneer)
  end

  it "can access index" do
    get welcome_path
    expect(response).to have_http_status(:success)
  end

  it "can access buyer log in" do
    get new_buyer_session_path
    expect(response).to have_http_status(:redirect)
  end

  it "can access seller log in" do
    get new_seller_session_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot access auctioneer log in" do
    get new_auctioneer_session_path
    expect(response).to have_http_status(:redirect)
  end

  it "can access buyer index" do
    get buyers_path
    expect(response).to have_http_status(:success)
  end

  it "can access seller index" do
    get sellers_path
    expect(response).to have_http_status(:success)
  end

  it "can access auctioneer index" do
    get auctioneers_path
    expect(response).to have_http_status(:success)
  end

  it "can access sales index" do
    get sales_path
    expect(response).to have_http_status(:success)
  end

  it "can access lots index" do
    get lots_path
    expect(response).to have_http_status(:success)
  end

  it "can access buyer show" do
    get buyer_path(buyer)
    expect(response).to have_http_status(:success)
  end

  # it "can access buyer bidding" do
  #   get buyer_bidding_path(buyer,sale)
  #   expect(response).to have_http_status(:success)
  # end

  it "can access seller's own show page" do
    get seller_path(seller)
    expect(response).to have_http_status(:success)
  end

  # it "cannot make a bid" do
  #   post bids_path(lot)
  #   expect(response).to have_http_status(:redirect)
  # end

  it "can create a sale" do
    get new_sale_path
    expect(response).to have_http_status(:success)
  end

  it "can create a seller" do
    get new_seller_path
    expect(response).to have_http_status(:success)
  end

  it "can create a buyer" do
    get new_buyer_path
    expect(response).to have_http_status(:success)
  end

  it "can create an auctioneer" do
    get new_auctioneer_path
    expect(response).to have_http_status(:success)
  end

  it "can edit an auctioneer" do
    get edit_auctioneer_path(auctioneer)
    expect(response).to have_http_status(:success)
  end

  it "can edit a buyer" do
    get edit_buyer_path(buyer)
    expect(response).to have_http_status(:success)
  end

  it "can edit a seller" do
    get edit_seller_path(seller)
    expect(response).to have_http_status(:success)
  end

  it "can edit a sale" do
    get edit_sale_path(sale)
    expect(response).to have_http_status(:success)
  end

  it "can edit a lot" do
    get edit_lot_path(lot)
    expect(response).to have_http_status(:success)
  end
end