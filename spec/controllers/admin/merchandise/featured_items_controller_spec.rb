require  'spec_helper'

describe Admin::Merchandise::FeaturedItemsController do
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
    @featured_item = Factory(:featured_item)
    get :show, :id => @featured_item.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    FeaturedItem.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    FeaturedItem.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_merchandise_featured_item_url(assigns[:featured_item]))
  end

  it "edit action should render edit template" do
    @featured_item = Factory(:featured_item)
    get :edit, :id => @featured_item.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @featured_item = Factory(:featured_item)
    FeaturedItem.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @featured_item.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @featured_item = Factory(:featured_item)
    FeaturedItem.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @featured_item.id
    response.should redirect_to(admin_merchandise_featured_item_url(assigns[:featured_item]))
  end

  it "destroy action should destroy model and redirect to index action" do
    @featured_item = Factory(:featured_item)
    delete :destroy, :id => @featured_item.id
    response.should redirect_to(admin_merchandise_featured_items_url)
    FeaturedItem.exists?(@featured_item.id).should be_false
  end
end