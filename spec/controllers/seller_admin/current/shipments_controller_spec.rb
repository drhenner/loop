require  'spec_helper'

describe SellerAdmin::Current::ShipmentsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:seller_admin_user)
    login_as(@user)
    @brand    = Factory(:brand)
    @variant  = Factory(:variant, :brand => @brand)
    User.any_instance.stubs(:brand_ids).returns([@brand])
  end

  it "index action should render index template" do
    @shipment = Factory(:shipment)
    @order_item = Factory(:order_item, :variant => @variant, :shipment => @shipment)
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    @shipment = Factory(:shipment)
    @order_item = Factory(:order_item, :variant => @variant, :shipment => @shipment)
    get :show, :id => @shipment.id
    response.should render_template(:show)
  end

  it "edit action should render edit template" do
    @shipment = Factory(:shipment)
    @order_item = Factory(:order_item, :variant => @variant, :shipment => @shipment)
    get :edit, :id => @shipment.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @shipment = Factory(:shipment)
    @order_item = Factory(:order_item, :variant => @variant, :shipment => @shipment)
    Shipment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @shipment.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @shipment = Factory(:shipment)
    @order_item = Factory(:order_item, :variant => @variant, :shipment => @shipment)
    Shipment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @shipment.id
    response.should redirect_to(seller_admin_current_shipment_url(assigns[:shipment]))
  end
end
