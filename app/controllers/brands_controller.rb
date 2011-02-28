class BrandsController < ApplicationController
  def index
    @brands = Brand.all
  end

  def show
    @brand = Brand.find(params[:id])
  end

  private

  def left_tabs
    @brands     ||= Brand.all
    @left_tabs  ||= @brands.map do |c|
      {:name => c.name, :params => {:brand_id => c.id}, :color => nil }
    end
  end

  def form_info

  end
end
