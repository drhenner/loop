require  'spec_helper'

describe SellerAdmin::ProductsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:seller_admin_user)
    login_as(@user)
  end

  it "index action should render index template" do
    @product = Factory(:product)
    User.any_instance.stubs(:seller_products).returns([@product])
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    @product = Factory(:product)
    User.any_instance.stubs(:all_seller_products).returns([@product])
    Array.any_instance.stubs(:find).returns(@product)
    get :show, :id => @product.id
    response.should render_template(:show)
  end
end
