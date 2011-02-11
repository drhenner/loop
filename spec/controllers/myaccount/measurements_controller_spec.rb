require  'spec_helper'

describe Myaccount::MeasurementsController do
  render_views

  before(:each) do
    activate_authlogic

    @user = Factory(:user)
    login_as(@user)
  end

  it "index action should render index template" do
    @measurement = Factory(:measurement, :user => @user)
    get :index
    response.should render_template(:index)
  end

  #it "show action should render show template" do
  #  @measurement = Factory(:measurement, :user => @user)
  #  get :show, :id => @measurement.id
  #  response.should render_template(:show)
  #end

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
    response.should redirect_to(myaccount_measurements_url())
  end

  it "edit action should render edit template" do
    @measurement = Factory(:measurement, :user => @user)
    get :edit, :id => @measurement.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @measurement = Factory(:measurement, :user => @user)
    Measurement.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @measurement.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @measurement = Factory(:measurement, :user => @user)
    Measurement.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @measurement.id
    response.should redirect_to(myaccount_measurements_url)
  end

end
