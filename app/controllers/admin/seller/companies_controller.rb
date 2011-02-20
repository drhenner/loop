class Admin::Seller::CompaniesController < Admin::Seller::BaseController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    form_info
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      flash[:notice] = "Successfully created company."
      redirect_to admin_seller_company_url(@company)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Successfully updated company."
      redirect_to admin_seller_company_url(@company)
    else
      form_info
      render :action => 'edit'
    end
  end

  private

  def form_info

  end
end
