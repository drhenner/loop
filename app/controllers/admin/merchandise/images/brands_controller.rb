class Admin::Merchandise::Images::BrandsController < Admin::BaseController
  def edit
    form_info
    @brand = Brand.includes(:images).find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update_attributes(params[:brand])
      flash[:notice] = "Successfully updated brand."
      redirect_to admin_merchandise_images_brand_url(@brand)
    else
      form_info
      render :action => 'edit'
    end
  end

  def show
    @brand = Brand.includes(:images).find(params[:id])
  end

  private

  def form_info

  end
end
