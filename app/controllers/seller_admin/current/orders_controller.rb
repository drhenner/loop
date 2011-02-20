class SellerAdmin::Current::OrdersController < SellerAdmin::BaseController
  def index
    params[:page] ||= 1
    params[:rows] ||= 15
    args = { :page => params[:page], :rows => params[:rows]}
    @orders = current_user.seller_orders(args)
  end

  def show
    @order = current_user.seller_orders.find(params[:id])
  end

  private

  def form_info

  end
end
