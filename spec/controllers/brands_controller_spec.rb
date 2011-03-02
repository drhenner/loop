require  'spec_helper'

describe BrandsController do
  render_views

  it "index action should render index template" do
    Factory(:product)
    get :index
    response.should render_template(:index)
  end

end
