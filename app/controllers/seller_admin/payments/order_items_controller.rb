class SellerAdmin::Payments::OrderItemsController < ApplicationController
  def index
    if params[:brand_id] && (current_user.admin? || current_user.brand_ids.include?(params[:brand_id].to_i))
      brand         = Brand.joins([:variants]).find(params[:brand_id])
      @contracts    = Contract.where(['brand_id = ?', brand.id])
      @order_items  = OrderItem.includes([:order, {:variant => :product}]).
                                where(['order_items.variant_id IN ? AND
                                        order_items.shipment_id IS NOT NULL', brand.variant_ids]).
                                paginate({:page => params[:page],:per_page => params[:rows]})

    else
      #current_user.brand_ids
    end
  end

  def show
    @order_item = OrderItem.find(params[:id])
  end

  private

  def form_info

  end
end
