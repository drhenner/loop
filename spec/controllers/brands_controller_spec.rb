require  'spec_helper'

describe BrandsController do
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    @brand = Factory(:brand)
    #@brands = [@brand]
    get :show, :id => @brand.id
    response.should render_template(:show)
  end
end
