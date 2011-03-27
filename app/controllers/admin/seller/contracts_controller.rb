class Admin::Seller::ContractsController < Admin::Seller::BaseController
  def index
    params[:page] ||= 1
    params[:rows] ||= 20
    @contracts = Contract.where('end_date IS NULL').paginate({:page => params[:page],:per_page => params[:rows]})
  end

  def show
    @contract = Contract.find(params[:id])
  end

  def new
    form_info
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(params[:contract])
    if @contract.save
      flash[:notice] = "Successfully created contract."
      redirect_to admin_seller_contract_url(@contract)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @contract = Contract.find(params[:id])
  end

  def update

    old_contract = Contract.find(params[:id])
    new_contract = Contract.new(params[:contract])
    if new_contract.save
      @contract = new_contract
      old_contract.update_attribute(:end_date, new_contract.start_date)
      flash[:notice] = "Successfully updated contract."
      redirect_to admin_seller_contract_url(@contract)
    else
      @contract = old_contract
      form_info
      render :action => 'edit'
    end
  end

  private

  def form_info
    @brands       = Brand.all.collect{|b| [b.name, b.id]}
    @percentages  = 0.upto(350).collect{|n| (n/10.0) }
  end
end
