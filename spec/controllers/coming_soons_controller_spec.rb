require  'spec_helper'

describe ComingSoonsController do
  render_views

  it "show action should render show template" do
    @user = Factory.build(:user)
    get :show
    response.should render_template(:show)
  end
end
