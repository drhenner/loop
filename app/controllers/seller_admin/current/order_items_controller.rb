class SellerAdmin::Current::OrderItemsController < SellerAdmin::BaseController
  def show
    @order = current_user.seller_orders(nil, params[:order_id])
    @order_item = @order.order_items.find(params[:id])
  end

  def edit
    form_info
    @order = current_user.seller_orders(nil, params[:order_id])
    @order_item = @order.order_items.find(params[:id])
  end

  def update
    # ship_item!
    @order = current_user.seller_orders(nil, params[:order_id])
    @order_item = @order.order_items.find(params[:id])
    if @order_item.update_attributes(params[:order_item])
      flash[:notice] = "Successfully updated order item."
      redirect_to seller_admin_current_order_order_item_url(@order, @order_item)
    else
      form_info
      render :action => 'edit'
    end
  end

  private

  def form_info

  end
end

