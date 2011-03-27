require  'spec_helper'

describe SellerAdmin::Payments::OrderItemsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:seller_admin_user)
    login_as(@user)
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "index action should render index template" do
    brand = Factory(:brand)
    get :index, :brand_id => brand.id
    response.should render_template(:index)
  end

  it "show action should render show template" do
    brand     = Factory(:brand)

    variant     = Factory(:variant, :brand => brand)
    order       = Factory(:order, :completed_at => Time.now)
    @order_item = Factory(:order_item, :order => order, :variant => variant)

    get :show, :id => @order_item.id
    response.should render_template(:show)
  end
end
