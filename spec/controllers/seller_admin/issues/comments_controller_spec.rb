require  'spec_helper'

describe SellerAdmin::Issues::CommentsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:seller_admin_user)
    brand = Factory(:brand)
    login_as(@user)
    @user.stubs(:brand_ids).returns(brand.id)
    @ticket = Factory(:ticket)
  end

  it "create action should render new template when model is invalid" do
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create, :ticket_id => @ticket.id
    response.should render_template('seller_admin/issues/tickets/show')
  end

  it "create action should redirect when model is valid" do

    Comment.any_instance.stubs(:valid?).returns(true)
    post :create, :ticket_id => @ticket.id
    response.should redirect_to(seller_admin_issues_ticket_url(@ticket))
  end
end
