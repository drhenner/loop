class Admin::Merchandise::Images::VariantsController < Admin::BaseController
  def edit
    form_info
    @variant = Variant.includes(:images).find(params[:id])
  end

  def update
    @variant = Variant.find(params[:id])
    if @variant.update_attributes(params[:variant])
      flash[:notice] = "Successfully updated variant."
      redirect_to admin_merchandise_images_variant_url(@variant)
    else
      form_info
      render :action => 'edit'
    end
  end

  def show
    @variant = Variant.includes(:images).find(params[:id])
  end

  private

  def form_info

  end
end
