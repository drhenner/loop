class Myaccount::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    form_info
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
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
