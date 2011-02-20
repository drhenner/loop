class Admin::Seller::Images::CompaniesController < Admin::Seller::BaseController
  def edit
    form_info
    @company  = Company.includes(:images).find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Successfully updated company."
      redirect_to admin_seller_images_company_url(@company)
    else
      form_info
      render :action => 'edit'
    end
  end

  def show
    @company  = Company.includes(:images).find(params[:id])
  end

  private

  def form_info

  end
end
