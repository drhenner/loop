class Myaccount::MeasurementsController < Myaccount::BaseController

  def index
    @measurement = current_user.measurement
  end

  def new
    form_info
    @measurement = Measurement.new
  end

  def create
    @measurement = Measurement.new(params[:measurement])
    @measurement.user = current_user
    if @measurement.save
      flash[:notice] = "Successfully created measurement."
      redirect_to myaccount_measurements_url()
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @measurement = Measurement.where(:user_id => current_user.id).find(params[:id])

  end

  def update
    @measurement = Measurement.where(:user_id => current_user.id).find(params[:id])
    if @measurement.user_id == current_user.id && @measurement.update_attributes(params[:measurement])
      flash[:notice] = "Successfully updated measurement."
      redirect_to myaccount_measurements_url()
    else
      form_info
      render :action => 'edit'
    end
  end

  private

  def form_info

  end
end
