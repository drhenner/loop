require  'spec_helper'

describe SellerAdmin::Issues::TicketBinsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:seller_admin_user)
    brand = Factory(:brand)
    login_as(@user)
    @user.stubs(:brand_ids).returns(brand.id)
  end

  it "show action should render show template" do
    @ticket = Factory(:ticket)
    get :show, :id => @ticket.id
    #response.should render_template('/seller_admin/issues/tickets/index')
  end
end
