class Admin::Merchandise::FeaturedItemsController < Admin::BaseController
  helper_method :sort_column, :sort_direction

  def index

    params[:page] ||= 1
    params[:rows] ||= 20
    args = { :page => params[:page], :rows => params[:rows]}
    @featured_items = FeaturedItem.order([sort_column, sort_direction].compact.join(' ')).
                      paginate({:page => params[:page],:per_page => params[:rows]})
  end

  def show
    @featured_item = FeaturedItem.find(params[:id])
  end

  def new
    form_info
    @featured_item = FeaturedItem.new
  end

  def create
    @featured_item = FeaturedItem.new(params[:featured_item])
    if @featured_item.save
      flash[:notice] = "Successfully created featured item."
      redirect_to admin_merchandise_featured_item_url(@featured_item)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @featured_item = FeaturedItem.find(params[:id])
  end

  def update
    @featured_item = FeaturedItem.find(params[:id])
    if @featured_item.update_attributes(params[:featured_item])
      flash[:notice] = "Successfully updated featured item."
      redirect_to admin_merchandise_featured_item_url(@featured_item)
    else
      form_info
      render :action => 'edit'
    end
  end

  def destroy
    @featured_item = FeaturedItem.find(params[:id])
    @featured_item.destroy
    flash[:notice] = "Successfully destroyed featured item."
    redirect_to admin_merchandise_featured_items_url
  end

  private

  def form_info
    @products = Product.select('id, name').all.map{|p| [p.name, p.id]}
  end

  def sort_column
    FeaturedItem.column_names.include?(params[:sort]) ? params[:sort] : "starts_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
