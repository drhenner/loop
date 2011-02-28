require  'spec_helper'

describe ColorsController do
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    @color = Factory(:color)
    get :show, :id => @color.id
    response.should render_template(:show)
  end
end
