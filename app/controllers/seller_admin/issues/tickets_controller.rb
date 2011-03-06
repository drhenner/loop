class SellerAdmin::Issues::TicketsController < SellerAdmin::Issues::BaseController

  def index
    params[:page] ||= 1
    params[:rows] ||= 20
    args = { :page => params[:page], :rows => params[:rows]}
    @tickets = Ticket.where(['tickets.brand_id IN (?) AND
                              tickets.active <> ? AND
                              tickets.issue_type = ?', current_user.brand_ids,
                                                            false,
                                                            Ticket::SELLER_TICKET_ISSUE]).
                      paginate({:page => params[:page],:per_page => params[:rows]})
  end

  def show
    @ticket = Ticket.includes(:comments).find(params[:id])
    @comment = Comment.new
  end

  def new
    form_info
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.tickets.new(params[:ticket])
    @ticket.issue_type = Ticket::SELLER_TICKET_ISSUE
    if @ticket.save
      flash[:notice] = "Successfully created ticket."
      redirect_to seller_admin_issues_ticket_url(@ticket)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @ticket = Ticket.includes(:comments).find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = "Successfully updated ticket."
      redirect_to seller_admin_issues_ticket_url(@ticket)
    else
      form_info
      render :action => 'edit'
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.inactive!
    flash[:notice] = "Successfully destroyed ticket."
    redirect_to seller_admin_issues_tickets_url
  end

  private

  def form_info
    @brands = current_user.brands.collect{|b| [b.name, b.id]}
  end

end
