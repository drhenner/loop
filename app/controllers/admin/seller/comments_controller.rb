class Admin::Seller::CommentsController < Admin::Seller::BaseController
  before_filter :load_data

  #def index
  #  @comments = @ticket.comments
  #end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    form_info
    @comment = Comment.new
  end

  def create
    @comment = @ticket.comments.new(params[:comment])
    @comment.created_by = current_user
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to admin_seller_ticket_url(@ticket)
    else
      form_info
      render :action => 'new'
    end
  end

  def edit
    form_info
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.user = current_user
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to admin_seller_ticket_url(@ticket)
    else
      form_info
      render :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to admin_seller_ticket_url(@ticket)
  end

  private

  def form_info

  end

  def load_data
    @ticket = Ticket.find(params[:ticket_id])
  end
end
