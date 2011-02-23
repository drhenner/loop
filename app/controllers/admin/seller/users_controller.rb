class Admin::Seller::UsersController < Admin::Seller::BaseController
  def index
    params[:page] ||= 1
    params[:rows] ||= 20
    @users = User.paginate({:page => params[:page],:per_page => params[:rows]})
  end

  def edit
    form_info
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.company_id = params[:user][:company_id]
    if @user.save
      flash[:notice] = "Successfully updated user."
      redirect_to admin_seller_user_url(@user)
    else
      form_info
      render :action => 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def form_info
    @companies = Company.all.collect{|c| [c.name, c.id]}
  end
end
