require  'spec_helper'

describe Admin::Seller::TicketsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:admin_user)
    login_as(@user)
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
    response.should redirect_to(admin_seller_ticket_url(assigns[:ticket]))
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
    response.should redirect_to(admin_seller_ticket_url(assigns[:ticket]))
  end

  it "destroy action should destroy model and redirect to index action" do
    @ticket = Factory(:ticket)
    delete :destroy, :id => @ticket.id
    response.should redirect_to(admin_seller_tickets_url)
    Ticket.exists?(@ticket.id).should be_false
  end
end
