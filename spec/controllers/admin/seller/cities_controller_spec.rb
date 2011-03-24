require  'spec_helper'

describe Admin::Seller::CitiesController do
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
    @city = Factory(:city)
    get :show, :id => @city.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    City.any_instance.stubs(:valid?).returns(false)
    post :create, :city => {:name => 'dallas', :state_id => '2'}
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    City.any_instance.stubs(:valid?).returns(true)
   # City.any_instance.stubs(:name).returns('Dave')
    post :create, :city => {:name => 'dallas', :state_id => '2'}
    response.should redirect_to(admin_seller_city_url(assigns[:city]))
  end

  it "edit action should render edit template" do
    @city = Factory(:city)
    get :edit, :id => @city.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @city = Factory(:city)
    City.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @city.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @city = Factory(:city)
    City.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @city.id
    response.should redirect_to(admin_seller_city_url(assigns[:city]))
  end

end
