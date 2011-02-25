class SellerAdmin::ProductsController < SellerAdmin::BaseController
  def index
    params[:page] ||= 1
    params[:rows] ||= 15
    args = { :page => params[:page], :rows => params[:rows]}
    @products = current_user.seller_products(args)
  end

  def show
    @product = current_user.all_seller_products.find(params[:id])
  end

  private

  def form_info

  end
end
