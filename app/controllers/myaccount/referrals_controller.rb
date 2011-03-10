class Myaccount::ReferralsController < Myaccount::BaseController
  def index
    @user_referrals = current_user.user_referrals
  end

  def show
    @referral = current_user.user_referrals.find(params[:id])
  end

  def new
    form_info
    @referral = UserReferral.new
  end

  def update
    emails = params[:user_referrals][:referral_email]
    @bad_referrals = current_user.create_referrals(emails)

    if @bad_referrals.empty?
      flash[:notice] = "Successfully created referral."
      redirect_to myaccount_referrals_url()
    else
      form_info
      render :action => 'new'
    end
  end

  private

  def form_info

  end
end
