class Myaccount::MeasurementsController < ApplicationController

  def index
    @measurement = current_user.measurement
  end

  def new
    form_info
    @measurement = current_user.measurement.new
  end

  def create
    @measurement = current_user.measurement.new(params[:measurement])
    if @measurement.save
      flash[:notice] = "Successfully created measurement."
      redirect_to myaccount_measurement_url(@measurement)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @measurement = current_user.measurement.find(params[:id])
  end

  def update
    @measurement = current_user.measurement.find(params[:id])
    if @measurement.update_attributes(params[:measurement])
      flash[:notice] = "Successfully updated measurement."
      redirect_to myaccount_measurement_url(@measurement)
    else
      form_info
      render :action => 'edit'
    end
  end

  private

  def form_info

  end
end
