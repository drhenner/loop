class Admin::Seller::TicketsController < Admin::Seller::BaseController
  helper_method :sort_column, :sort_direction
  def index
    params[:page] ||= 1
    params[:rows] ||= 20
    args = { :page => params[:page], :rows => params[:rows]}
    @tickets = Ticket.where(['tickets.issue_type = ?', Ticket::SELLER_TICKET_ISSUE]).
                      order([sort_column, sort_direction].compact.join(' ')).
                      paginate({:page => params[:page],:per_page => params[:rows]})
  end

  def show
    @ticket = Ticket.find(params[:id])
    @comment = Comment.new
  end

  def new
    form_info
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      flash[:notice] = "Successfully created ticket."
      redirect_to admin_seller_ticket_url(@ticket)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = "Successfully updated ticket."
      redirect_to admin_seller_ticket_url(@ticket)
    else
      form_info
      render :action => 'edit'
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    flash[:notice] = "Successfully destroyed ticket."
    redirect_to admin_seller_tickets_url
  end

  private

  def form_info
    roles = Role.where(['id IN (?)', Role::ADMIN_ROLE_IDS]).includes(:users)
    @admin_users = []
    roles.each do |role|
      role.users.each {|u| @admin_users << u unless @admin_users.include?(u) }
    end

    @brands = Brand.select('id, name').collect{|b| [b.name, b.id] }
  end

  def sort_column
    Ticket.column_names.include?(params[:sort]) ? params[:sort] : "subject"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
