class Admin::Seller::Images::OwnersController < Admin::Seller::BaseController
  def edit
    form_info
    @owner = Owner.includes(:images).find(params[:id])
  end

  def update
    @owner = Owner.find(params[:id])
    if @owner.update_attributes(params[:owner])
      flash[:notice] = "Successfully updated owner."
      redirect_to admin_seller_images_owner_url(@owner)
    else
      form_info
      render :action => 'edit'
    end
  end

  def show
    @owner = Owner.includes(:images).find(params[:id])
  end

  private

  def form_info

  end
end
