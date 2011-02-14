require  'spec_helper'

describe SellerAdmin::OverviewsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:seller_admin_user)
    login_as(@user)
  end

  it "show action should render show template" do
    get :show
    response.should render_template(:show)
  end
end