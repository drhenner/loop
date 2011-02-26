class SellerAdmin::Current::ShipmentsController < SellerAdmin::BaseController
  def index
    @shipments = Shipment.seller_shipments(current_user.brand_ids)
  end

  def show
    @shipment = Shipment.seller_shipments(current_user.brand_ids).find(params[:id])

  end

  def edit
    form_info
    @shipment = Shipment.seller_shipments(current_user.brand_ids).find(params[:id])
  end

  def update
    @shipment = Shipment.seller_shipments(current_user.brand_ids).find(params[:id])
    if @shipment.update_attributes(params[:shipment])
      flash[:notice] = "Successfully updated shipment."
      redirect_to seller_admin_current_shipment_url(@shipment)
    else
      form_info
      render :action => 'edit'
    end
  end

  def ship
    #load_info
    @shipment = Shipment.seller_shipments(current_user.brand_ids).find(params[:id])

    respond_to do |format|
      if @shipment.ship!
        format.html { render :show, :notice => 'Shipment was successfully updated.' }
      else
        format.html { render :show, :error => 'Shipment could not be shipped!!!' }
      end
    end
  end

  private

  def form_info

  end
end
