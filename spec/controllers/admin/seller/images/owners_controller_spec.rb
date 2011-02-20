require  'spec_helper'

describe Admin::Seller::Images::OwnersController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:admin_user)
    login_as(@user)
  end

  it "edit action should render edit template" do
    @owner = Factory(:owner)
    get :edit, :id => @owner.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @owner = Factory(:owner)
    Owner.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @owner.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @owner = Factory(:owner)
    Owner.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @owner.id
    response.should redirect_to(admin_seller_images_owner_url(assigns[:owner]))
  end

  it "show action should render show template" do
    @owner = Factory(:owner)
    get :show, :id => @owner.id
    response.should render_template(:show)
  end
end