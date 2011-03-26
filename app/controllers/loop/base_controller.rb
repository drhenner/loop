class Loop::BaseController < ApplicationController
  skip_before_filter :redirect_to_coming_soon
  layout 'coming_soon'

end