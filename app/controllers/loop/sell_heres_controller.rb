class Loop::SellHeresController < ApplicationController
  def show
    @feedback = SellerFeedback.new
    form_info
  end

  def new
    @feedback = SellerFeedback.new
    form_info
  end

  def create
    @feedback = SellerFeedback.new(params[:seller_feedback])
    add_http_details
    if @feedback.not_spam? && @feedback.save
      flash[:notice] = "Successfully created sell here."
      redirect_to loop_sell_here_url()
    else
      form_info
      render :action => 'show'
    end
  end

  private

  def form_info

  end

  def add_http_details
    @feedback.user_id     = current_user ? current_user.id : Feedback::DEFAULT_USER_ID
    @feedback.name        = current_user.name if current_user
    @feedback.email       = current_user.email if current_user
    @feedback.user_ip     = request.remote_ip
    @feedback.user_agent  = request.user_agent
    @feedback.referrer    = request.referrer
    @feedback.permalink   = request.referrer
  end
=begin
t.integer :user_id
t.string :title
t.string :name
t.text    :content
t.string :email
t.string :website

t.string :user_ip
t.string :permalink
t.string :user_agent
t.string :referrer
=end

end
