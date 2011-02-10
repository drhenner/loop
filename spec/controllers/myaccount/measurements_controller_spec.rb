require  'spec_helper'

describe Myaccount::MeasurementsController do
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    @measurement = Factory(:measurement)
    get :show, :id => @measurement.id
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Measurement.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Measurement.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(myaccount_measurement_url(assigns[:measurement]))
  end
  
  it "edit action should render edit template" do
    @measurement = Factory(:measurement)
    get :edit, :id => @measurement.id
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    @measurement = Factory(:measurement)
    Measurement.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @measurement.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @measurement = Factory(:measurement)
    Measurement.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @measurement.id
    response.should redirect_to(myaccount_measurement_url(assigns[:measurement]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    @measurement = Factory(:measurement)
    delete :destroy, :id => @measurement.id
    response.should redirect_to(myaccount_measurements_url)
    Measurement.exists?(@measurement.id).should be_false
  end
end
