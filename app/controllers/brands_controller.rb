class BrandsController < ApplicationController
  def index
    params[:page] ||= 1
    params[:rows] ||= 8
    @products = Product.find_all_with_brand(brand_id).paginate(:page => params[:page], :per_page => params[:rows])
  end

  private

  def left_tabs
    @brands     ||= Brand.all
    @left_tabs  ||= @brands.map do |c|
      {:name => c.name, :params => {:brand_id => c.id}, :color => nil }
    end
  end

  def brand_id
    params[:id] ? params[:id] : Brand.default_brand_id
  end

  def form_info

  end
end
