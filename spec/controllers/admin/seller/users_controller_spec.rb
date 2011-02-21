require  'spec_helper'

describe Admin::Seller::UsersController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:admin_user)
    login_as(@user)
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "edit action should render edit template" do
    @user = Factory(:user)
    get :edit, :id => @user.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @user = Factory(:user)
    @company = Factory(:company)
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @user.id, :user => {:company_id => @company.id}
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @user = Factory(:user)
    @company = Factory(:company)
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @user.id, :user => {:company_id => @company.id}
    response.should redirect_to(admin_seller_user_url(assigns[:user]))
  end

  it "show action should render show template" do
    @user = Factory(:user)
    get :show, :id => @user.id
    response.should render_template(:show)
  end
end