module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_auctioneer
      flash.clear
      # if you have rails_admin. You can redirect anywhere really
      redirect_to(lots_path) && return
    elsif current_buyer
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(buyer_path(current_buyer)) && return
    elsif current_seller
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(seller_path(current_seller)) && return
    end
  end
end