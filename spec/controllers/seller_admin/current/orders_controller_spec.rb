require  'spec_helper'
=begin
describe SellerAdmin::Current::OrdersController do
#  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:seller_admin_user)
    login_as(@user)
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    @order = Factory(:order)
    get :show, :id => @order.id
    response.should render_template(:show)
  end

end
=end