class SellerAdmin::Issues::TicketBinsController < SellerAdmin::Issues::BaseController
  def show
    params[:page] ||= 1
    params[:rows] ||= 20
    args = { :page => params[:page], :rows => params[:rows]}
    @tickets = Ticket.where(['tickets.brand_id IN (?) AND
                              tickets.active <> ?', current_user.brand_ids, false]).
                      where(['tickets.status = ?', params[:id]]).
                      paginate({:page => params[:page],:per_page => params[:rows]})

    form_info
    render :template => '/seller_admin/issues/tickets/index'
  end

  private

  def form_info

  end
end
