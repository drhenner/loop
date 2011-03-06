require  'spec_helper'

describe Admin::Seller::CommentsController do
  render_views

  before(:each) do
    activate_authlogic
    @user = Factory(:admin_user)
    login_as(@user)
    @ticket = Factory(:ticket)
  end

  #it "index action should render index template" do
  #  get :index, :ticket => @ticket.id
  #  response.should render_template(:index)
  #end

  it "show action should render show template" do

    @comment = Factory(:comment)
    get :show, :ticket_id => @ticket.id, :id => @comment.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new, :ticket_id => @ticket.id
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create, :ticket_id => @ticket.id
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Comment.any_instance.stubs(:valid?).returns(true)
    post :create, :ticket_id => @ticket.id
    response.should redirect_to(admin_seller_ticket_url(@ticket))
  end

  it "edit action should render edit template" do
    @comment = Factory(:comment)
    get :edit, :ticket_id => @ticket.id, :id => @comment.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @comment = Factory(:comment)
    Comment.any_instance.stubs(:valid?).returns(false)
    put :update, :ticket_id => @ticket.id, :id => @comment.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @comment = Factory(:comment)
    Comment.any_instance.stubs(:valid?).returns(true)
    put :update, :ticket_id => @ticket.id, :id => @comment.id
    response.should redirect_to(admin_seller_ticket_url(@ticket))
  end

  it "destroy action should destroy model and redirect to index action" do
    @comment = Factory(:comment)
    delete :destroy, :ticket_id => @ticket.id, :id => @comment.id
    response.should redirect_to(admin_seller_ticket_url(@ticket))
    Comment.exists?(@comment.id).should be_false
  end
end
