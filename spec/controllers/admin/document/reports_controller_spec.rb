require  'spec_helper'

describe Admin::Document::ReportsController do
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    @report = Factory(:report)
    get :show, :id => @report.id
    response.should render_template(:show)
  end
  
  it "create action should render new template when model is invalid" do
    Report.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Report.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_document_report_url(assigns[:report]))
  end
end
