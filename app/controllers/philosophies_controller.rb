class PhilosophiesController < ApplicationController
  skip_before_filter :redirect_to_coming_soon
layout 'coming_soon'
  def show
  end

  private

  def form_info

  end
end
