require  'spec_helper'

describe Admin::Seller::Images::CompaniesController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:admin_user)
    login_as(@user)
  end

  it "edit action should render edit template" do
    @company = Factory(:company)
    get :edit, :id => @company.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @company = Factory(:company)
    Company.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @company.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @company = Factory(:company)
    Company.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @company.id
    response.should redirect_to(admin_seller_images_company_url(assigns[:company]))
  end

  it "show action should render show template" do
    @company = Factory(:company)
    get :show, :id => @company.id
    response.should render_template(:show)
  end
end