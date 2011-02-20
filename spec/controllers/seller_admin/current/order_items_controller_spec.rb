require  'spec_helper'

describe SellerAdmin::Current::OrderItemsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:seller_admin_user)
    login_as(@user)
  end
=begin
  it "show action should render show template" do
    @order = Factory(:order_with_an_item)
    @order_item = @order.order_items.first
    User.any_instance.stubs(:seller_orders).returns(@order)
    User.any_instance.stubs(:order_items).returns([@order_item])
    Array.any_instance.stubs(:find).returns(@order_item)


    get :show, :order_id => @order.id,:id => @order_item.id
    response.should render_template(:show)
  end

  it "edit action should render edit template" do
    @order = Factory(:order_with_an_item)
    @order_item = @order.order_items.first
    User.any_instance.stubs(:seller_orders).returns([@order])

    get :edit, :order_id => @order.id, :id => @order_item.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @order = Factory(:order)
    @order_item = Factory(:order_item, :order => @order)
    User.any_instance.stubs(:seller_orders).returns([@order])
    OrderItem.any_instance.stubs(:valid?).returns(false)
    put :update, :order_id => @order.id, :id => @order_item.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @order = Factory(:order)
    @order_item = Factory(:order_item, :order => @order)
    User.any_instance.stubs(:seller_orders).returns([@order])
    OrderItem.any_instance.stubs(:valid?).returns(true)
    put :update, :order_id => @order.id, :id => @order_item.id
    response.should redirect_to(seller_admin_current_order_order_item_url(assigns[:order_item]))
  end
=end
end
