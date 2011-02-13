require  'spec_helper'

describe Loop::CustomerServicesController do
  render_views

  it "show action should render show template" do
    @customer_services = Factory(:customer_service_feedback)
    get :show, :id => @customer_services.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    CustomerServiceFeedback.any_instance.stubs(:valid?).returns(false)
    CustomerServiceFeedback.any_instance.stubs(:spam?).returns(false)
    post :create
    response.should render_template(:show)
  end

  it "create action should redirect when model is valid" do
    CustomerServiceFeedback.any_instance.stubs(:valid?).returns(true)
    CustomerServiceFeedback.any_instance.stubs(:spam?).returns(false)
    post :create
    response.should redirect_to(loop_customer_service_url(assigns[:customer_service_feedback]))
  end
end
