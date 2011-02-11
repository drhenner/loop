class Myaccount::UsersController < Myaccount::BaseController
  def show
    @user = current_user
  end

  def edit
    form_info
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to myaccount_user_url(@user)
    else
      form_info
      render :action => 'edit'
    end
  end

  private

  def form_info

  end
end
