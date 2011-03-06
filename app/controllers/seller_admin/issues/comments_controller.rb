class SellerAdmin::Issues::CommentsController < SellerAdmin::Issues::BaseController
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment        = @ticket.comments.new(params[:comment])
    @comment.author = current_user
    #@comment.user   = current_user
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to seller_admin_issues_ticket_url(@ticket)
    else
      form_info
      render :template => 'seller_admin/issues/tickets/show'
    end
  end

  private

  def form_info

  end
end
