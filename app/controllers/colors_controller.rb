class ColorsController < ApplicationController

  #helper_method :left_tabs

  def index
    @colors     ||= Color.all
  end

  def show
    @color = Color.find(params[:id])
  end

  private

  def left_tabs
    @colors     ||= Color.all
    @left_tabs  ||= @colors.map do |c|
      {:name => c.name, :params => {:color_id => c.id}, :color => c.css_color }
    end
  end

  def form_info

  end
end
