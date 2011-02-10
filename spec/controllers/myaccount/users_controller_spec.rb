require  'spec_helper'

describe Myaccount::UsersController do
  render_views

  it "show action should render show template" do
    @user = Factory(:user)
    get :show, :id => @user.id
    response.should render_template(:show)
  end
  
  it "edit action should render edit template" do
    @user = Factory(:user)
    get :edit, :id => @user.id
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    @user = Factory(:user)
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @user.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @user = Factory(:user)
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @user.id
    response.should redirect_to(myaccount_user_url(assigns[:user]))
  end
end
