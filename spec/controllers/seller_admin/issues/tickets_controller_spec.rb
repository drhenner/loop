require  'spec_helper'

describe SellerAdmin::Issues::TicketsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:seller_admin_user)
    brand = Factory(:brand)
    login_as(@user)
    @user.stubs(:brand_ids).returns(brand.id)
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    @ticket = Factory(:ticket)
    get :show, :id => @ticket.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Ticket.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Ticket.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(seller_admin_issues_ticket_url(assigns[:ticket]))
  end

  it "edit action should render edit template" do
    @ticket = Factory(:ticket)
    get :edit, :id => @ticket.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @ticket = Factory(:ticket)
    Ticket.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @ticket.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @ticket = Factory(:ticket)
    Ticket.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @ticket.id
    response.should redirect_to(seller_admin_issues_ticket_url(assigns[:ticket]))
  end

  it "destroy action should destroy model and redirect to index action" do
    @ticket = Factory(:ticket)
    delete :destroy, :id => @ticket.id
    response.should redirect_to(seller_admin_issues_tickets_url)
    Ticket.exists?(@ticket.id).should be_false
  end
end