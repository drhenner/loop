require  'spec_helper'

describe Admin::Merchandise::Images::VariantsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:admin_user)
    login_as(@user)
  end

  it "edit action should render edit template" do
    @variant = Factory(:variant)
    get :edit, :id => @variant.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @variant = Factory(:variant)
    Variant.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @variant.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @variant = Factory(:variant)
    Variant.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @variant.id
    response.should redirect_to(admin_merchandise_images_variant_url(assigns[:variant]))
  end

  it "show action should render show template" do
    @variant = Factory(:variant)
    get :show, :id => @variant.id
    response.should render_template(:show)
  end
end