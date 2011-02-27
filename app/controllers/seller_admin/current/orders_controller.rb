class SellerAdmin::Current::OrdersController < SellerAdmin::BaseController
  def index
    params[:page] ||= 1
    params[:rows] ||= 20
    args = { :page => params[:page], :rows => params[:rows]}
    @orders = current_user.seller_orders(args)
  end

  def show
    @order = current_user.seller_orders.find(params[:id])
  end

  def update
    @order    = Order.find(params[:id])
    invoice   = @order.invoices.find(params[:invoice_id])

    @payment   = @order.capture_invoice(invoice)

##  several things happen on this request
# => Payment is captured
# => Invoice is updated to log leger transactions
# => Shipment is marked as ready to send and associated to the order_items
# => If everything works send the user to the shipment page


## TODO
# => Allow partial payments
# => mark only order_items that will be shipped

    respond_to do |format|
      if @payment && @payment.success?
        @shipments = Shipment.create_shipments_with_items(@order)
        # reload order
        format.html { render :partial => 'success_message' }
        #format.html { redirect_to(admin_fulfillment_order_path(@order), :notice => 'Shipment was successfully updated.') }
      else
        format.html { render :partial => 'failure_message' }
      end
    end
  end

  private

  def form_info

  end
end
