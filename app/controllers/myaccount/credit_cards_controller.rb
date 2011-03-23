class Myaccount::CreditCardsController < Myaccount::BaseController
  def index
    @credit_cards = current_user.payment_profiles
  end

  def show
    @credit_card = current_user.payment_profiles.find(params[:id])
  end

  def new
    form_info
    @credit_card = current_user.payment_profiles.new(:first_name => nil)
  end

  def create
    @credit_card = current_user.payment_profiles.new(params[:credit_card])

    @credit_card.last_digits  = params[:credit_card][:last_digits]
    @credit_card.month        = params[:credit_card][:month]
    @credit_card.year         = params[:credit_card][:year]
    @credit_card.first_name   = params[:credit_card][:first_name]
    @credit_card.last_name    = params[:credit_card][:last_name]
    @credit_card.number       = params[:credit_card][:number]
    @credit_card.cvv          = params[:credit_card][:cvv]

    if @credit_card.save
      flash[:notice] = "Successfully created credit card."
      redirect_to myaccount_credit_card_url(@credit_card)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @credit_card = current_user.payment_profiles.find(params[:id])
  end

  def update

    @credit_card = current_user.payment_profiles.new(params[:credit_card])

    @credit_card.last_digits  = params[:credit_card][:last_digits]
    @credit_card.month        = params[:credit_card][:month]
    @credit_card.year         = params[:credit_card][:year]
    @credit_card.first_name   = params[:credit_card][:first_name]
    @credit_card.last_name    = params[:credit_card][:last_name]
    @credit_card.number       = params[:credit_card][:number]
    @credit_card.cvv          = params[:credit_card][:cvv]
    if @credit_card.save
      credit_card = current_user.payment_profiles.find(params[:id])
      credit_card.inactivate!
      flash[:notice] = "Successfully updated credit card."
      redirect_to myaccount_credit_card_url(@credit_card)
    else
      @credit_card = current_user.payment_profiles.find(params[:id])
      form_info
      render :action => 'edit'
    end
  end

  def destroy
    @credit_card = current_user.payment_profiles.find(params[:id])
    @credit_card.inactivate!
    flash[:notice] = "Successfully destroyed credit card."
    redirect_to myaccount_credit_cards_url
  end

  private

  def form_info
    @addresses = current_user.addresses.map{|a| [a.address_lines, a.id]}
  end
end