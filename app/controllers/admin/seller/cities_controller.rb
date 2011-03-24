class Admin::Seller::CitiesController < Admin::Seller::BaseController
  def index
    @cities = City.all
  end

  def show
    @city = City.find(params[:id])
  end

  def new
    form_info
    @city = City.new
  end

  def create
    @city = City.new(params[:city])
    if @city.save
      flash[:notice] = "Successfully created city."
      redirect_to admin_seller_city_url(@city)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    if @city.update_attributes(params[:city])
      flash[:notice] = "Successfully updated city."
      redirect_to admin_seller_city_url(@city)
    else
      form_info
      render :action => 'edit'
    end
  end

  def destroy
    #@city = City.find(params[:id])
    #@city.destroy
    flash[:notice] = "You arent allowed to do that!!!  Ask for this to be inactive."
    #redirect_to admin_seller_cities_url
  end

  private

  def form_info
    @states = State.form_selector
  end
end