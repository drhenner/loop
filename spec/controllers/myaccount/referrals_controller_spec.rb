require  'spec_helper'

describe Myaccount::ReferralsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:user_with_referral)
    login_as(@user)
    #@user.stubs(:referrals).returns(@referral)
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

end

describe Myaccount::ReferralsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:user)
    login_as(@user)
  end

  #it "show action should render show template" do
  #  @referral = Factory(:user)
  #  get :show, :id => @referral.id
  #  response.should render_template(:show)
  #end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    UserReferral.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @user.id, :user_referrals =>{ :referral_email => ['heeh@gmmm.com', 'dddd@fffff.com']}
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    UserReferral.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @user.id, :user_referrals =>{ :referral_email => ['heeh@gmmm.com']}
    response.should redirect_to(myaccount_referrals_url)
  end
end