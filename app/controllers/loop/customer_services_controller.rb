class Loop::CustomerServicesController < Loop::BaseController
  def show
    form_info
    @customer_services = CustomerServiceFeedback.new
  end

  def new
    form_info
    @customer_services = CustomerServiceFeedback.new
  end

  def create
    @customer_services = CustomerServiceFeedback.new(params[:customer_service_feedback])
    add_http_details
    if @customer_services.not_spam? && @customer_services.save
      flash[:notice] = "Successfully created customer services."
      redirect_to loop_customer_service_url()
    else
      form_info
      render :action => 'show'
    end
  end

  private

  def form_info

  end

  def add_http_details
    @customer_services.user_id     = current_user ? current_user.id : Feedback::DEFAULT_USER_ID
    @customer_services.name        = current_user.name if current_user
    @customer_services.email       = current_user.email if current_user
    @customer_services.user_ip     = request.remote_ip
    @customer_services.user_agent  = request.user_agent
    @customer_services.referrer    = request.referrer
    @customer_services.permalink   = request.referrer
  end
end
