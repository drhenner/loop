class ComingSoonsController < ApplicationController
  skip_before_filter :redirect_to_coming_soon

  layout 'coming_soon'

  def show
    @user = User.new()
  end

  def create
    @user = User.new(params[:user])
    @user.format_birth_date(params[:user][:birth_date]) if params[:user][:birth_date].present?
      # Saving without session maintenance to skip
      # auto-login which can't happen here because
      # the User has not yet been activated
      if @user.save_without_session_maintenance
        @user.deliver_coming_soon_message!
        flash[:notice] = "You will be notified when the business doors open!"
        render :show
      else
        flash[:error] = "Oops,  Something went wrong."
        render :action => :show
      end
  end

  private

  def form_info

  end
end
