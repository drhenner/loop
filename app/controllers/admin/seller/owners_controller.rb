class Admin::Seller::OwnersController < Admin::Seller::BaseController
  def index
    @owners = Owner.all
  end

  def show
    @owner = Owner.find(params[:id])
  end

  def new
    form_info
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(params[:owner])
    if @owner.save
      flash[:notice] = "Successfully created owner."
      redirect_to admin_seller_owner_url(@owner)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @owner = Owner.find(params[:id])
  end

  def update
    @owner = Owner.find(params[:id])
    if @owner.update_attributes(params[:owner])
      flash[:notice] = "Successfully updated owner."
      redirect_to admin_seller_owner_url(@owner)
    else
      form_info
      render :action => 'edit'
    end
  end

  private

  def form_info
    @companies = Company.all
  end
end
