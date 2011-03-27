require  'spec_helper'

describe Admin::Seller::ContractsController do
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
    @contract = Factory(:contract)
    get :show, :id => @contract.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Contract.any_instance.stubs(:valid?).returns(false)
    post :create, :contract => {:brand_id => '1', :start_date => '2011-10-10', :flash_percent => '10', :store_percent => '20'}
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Contract.any_instance.stubs(:valid?).returns(true)
    post :create, :contract => {:brand_id => '1', :start_date => '2011-10-10', :flash_percent => '10', :store_percent => '20'}
    response.should redirect_to(admin_seller_contract_url(assigns[:contract]))
  end

  it "edit action should render edit template" do
    @contract = Factory(:contract)
    get :edit, :id => @contract.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @contract = Factory(:contract)
    Contract.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @contract.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @contract = Factory(:contract)
    Contract.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @contract.id
    response.should redirect_to(admin_seller_contract_url(assigns[:contract]))
  end

end
