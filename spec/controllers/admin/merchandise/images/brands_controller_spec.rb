require  'spec_helper'

describe Admin::Merchandise::Images::BrandsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:admin_user)
    login_as(@user)
  end

  it "edit action should render edit template" do
    @brand = Factory(:brand)
    get :edit, :id => @brand.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @brand = Factory(:brand)
    Brand.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @brand.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @brand = Factory(:brand)
    Brand.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @brand.id
    response.should redirect_to(admin_merchandise_images_brand_url(assigns[:brand]))
  end

  it "show action should render show template" do
    @brand = Factory(:brand)
    get :show, :id => @brand.id
    response.should render_template(:show)
  end
end
