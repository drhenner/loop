class SellerAdmin::Issues::TicketsController < ApplicationController
  def index
    params[:page] ||= 1
    params[:rows] ||= 20
    args = { :page => params[:page], :rows => params[:rows]}
    @tickets = Ticket.where(['tickets.brand_id IN (?)', current_user.brand_ids]).
                      paginate({:page => params[:page],:per_page => params[:rows]})
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    form_info
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(params[:ticket])
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
    @ticket = Ticket.find(params[:id])
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
    @ticket.destroy
    flash[:notice] = "Successfully destroyed ticket."
    redirect_to seller_admin_issues_tickets_url
  end

  private

  def form_info

  end
end
