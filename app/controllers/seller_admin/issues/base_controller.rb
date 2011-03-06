class SellerAdmin::Issues::BaseController < SellerAdmin::BaseController
  helper_method :ticket_summary
  layout 'seller_issues'

  private

  def ticket_summary
    @ticket_summary ||= Ticket.summary(current_user.brand_ids)
  end
end