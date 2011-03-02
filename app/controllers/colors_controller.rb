class ColorsController < ApplicationController

  #helper_method :left_tabs

  def index
    params[:page] ||= 1
    params[:rows] ||= 8
    @products = Product.find_all_with_color(color_id).paginate(:page => params[:page], :per_page => params[:rows])
  end

  private

  def left_tabs
    @colors     ||= Color.all
    @left_tabs  ||= @colors.map do |c|
      {:name => c.name, :params => {:color_id => c.id}, :color => c.css_color }
    end
  end

  def color_id
    params[:id] ? params[:id] : Color.default_color_id
  end

  def form_info

  end
end
