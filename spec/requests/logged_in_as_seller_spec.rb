require "rails_helper"

RSpec.describe 'Loged in as Seller' do

  let(:seller){create(:seller)}
  let(:seller2){build_stubbed(:seller)}

  before(:example) do
    sign_in(seller)
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

  it "can access auctioneer log in" do
    get new_auctioneer_session_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot access buyer index" do
    get buyers_path
    expect(response).to have_http_status(:redirect)
  end

  it "can access seller index" do
    get sellers_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot access auctioneer index" do
    get auctioneers_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot access sales index" do
    get sales_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot access lots index" do
    get lots_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot access buyer show" do
    get buyer_path(1)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot access buyer bidding" do
    get buyer_bidding_path(1,1)
    expect(response).to have_http_status(:redirect)
  end

  it "can access seller's own show page" do
    get seller_path(seller)
    expect(response).to have_http_status(:success)
  end

  it "cannot access a different seller's show page" do
    get seller_path(seller2)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot make a bid" do
    post bids_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot create a sale" do
    post sales_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot create a seller" do
    post sellers_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot create a buyer" do
    post buyers_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot create an auctioneer" do
    post auctioneers_path
    expect(response).to have_http_status(:redirect)
  end

  it "cannot edit an auctioneer" do
    get edit_auctioneer_path(1)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot edit a buyer" do
    get edit_buyer_path(1)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot edit a seller" do
    get edit_seller_path(1)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot edit a sale" do
    get edit_sale_path(1)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot edit a lot" do
    get edit_lot_path(1)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot reset bids and fees" do
    post reset_bids_and_fees_lot_path(1)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot delete lot pictures" do
    delete delete_pictures_lot_path(1)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot delete lot image" do
    delete delete_image_lot_path(1)
    expect(response).to have_http_status(:redirect)
  end

  it "cannot delete main lot image" do
    delete delete_main_image_lot_path(1)
    expect(response).to have_http_status(:redirect)
  end
end