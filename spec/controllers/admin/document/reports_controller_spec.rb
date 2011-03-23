require  'spec_helper'

describe Admin::Document::ReportsController do
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

  #it "show action should render show template" do
  #  @report = Factory(:report)
  #  get :show, :id => @report.id, :format => 'pdf'
  #  response.should render_template(:show)
  #end

  it "create action should render new template when model is invalid" do
    @brand = Factory(:brand)
    @variant = Factory(:variant, :brand => @brand)

    Report.any_instance.stubs(:valid?).returns(false)
    post :create, :report => {:brand_id => @brand.id }
  end

  it "create action should redirect when model is valid" do
    @brand = Factory(:brand)
    @variant = Factory(:variant, :brand => @brand)
    Report.any_instance.stubs(:valid?).returns(true)
    post :create, :report => {:brand_id => @brand.id }
  end
end
