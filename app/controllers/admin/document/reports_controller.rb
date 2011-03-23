class Admin::Document::ReportsController < Admin::BaseController
  def index

    params[:page] ||= 1
    params[:rows] ||= 20
    args = { :page => params[:page], :per_page => params[:rows]}
    @reports = Report.paginate(args)
  end

  def show
    @report = Report.find(params[:id])
  end

  ## this method generates the PDF to be saved by paperclip in report.rb model
  #
  # params[:report] => {brand_id, :starts_at, :ends_at}
  def create
    brand = Brand.joins([:variants]).find(params[:report][:brand_id])
    @order_items = OrderItem.includes([{:shipping_rate => :shipping_method}, {:variant => :product}]).
                            where(["order_items.variant_id IN (?)", brand.variant_ids])
    #args = params[:report]
    #@invoice = Report.save_pdf(args[:brand_id], args[:starts_at], args[:ends_at])

    respond_to do |format|
      #format.pdf { render :layout => false }
      format.pdf { prawnto :prawn=> {:skip_page_creation=>true} }
    end
  end

  private

  def form_info

  end

end