require  'spec_helper'

describe Myaccount::ReferralsController do
  render_views

  before(:each) do
    activate_authlogic

    @user = Factory(:user)
    login_as(@user)
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    @referral = Factory(:referral)
    get :show, :id => @referral.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Referral.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Referral.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(loop_referral_url(assigns[:referral]))
  end
end
