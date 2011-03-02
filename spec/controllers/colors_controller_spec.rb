require  'spec_helper'

describe ColorsController do
  render_views

  it "index action should render index template" do
    Factory(:product)
    get :index
    response.should render_template(:index)
  end
  
end
