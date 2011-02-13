require  'spec_helper'

describe Loop::SellHeresController do
  render_views

  it "show action should render show template" do
    @feedback = Factory(:seller_feedback)
    get :show
    response.should render_template(:show)
  end

  it "edit action should render edit template" do
    @feedback = Factory(:seller_feedback)
    get :new
    response.should render_template(:new)
  end


  it "create action should render new template when model is invalid" do
    SellerFeedback.any_instance.stubs(:valid?).returns(false)
    SellerFeedback.any_instance.stubs(:spam?).returns(false)

    post :create
    response.should render_template(:show)
  end

  it "create action should redirect when model is valid" do
    SellerFeedback.any_instance.stubs(:valid?).returns(true)
    SellerFeedback.any_instance.stubs(:spam?).returns(false)
    post :create
    response.should redirect_to(loop_sell_here_url())
  end
end
