class SellerAdmin::BaseController < ApplicationController
  layout 'seller_admin'

  before_filter :verify_seller_admin

  private

  def verify_seller_admin
    redirect_to root_url and return if !current_user
    redirect_to root_url if !(current_user.seller_admin? || current_user.admin?)
  end
end