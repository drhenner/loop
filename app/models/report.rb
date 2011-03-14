class Report < ActiveRecord::Base
  include BrandOrderItemsPrinter
  belongs_to :reportable, :polymorphic => true

  has_attached_file :document,
                    :default_style => :brand,
                    :url => "/assets/reports/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/reports/:id/:style/:basename.:extension"
#image_tag @product.photo.url(:small)
  validates_attachment_presence :document
  validates_attachment_size     :document, :less_than => 20.megabytes
  validates_attachment_content_type :document, :content_type => ['application/pdf', 'text/plain','application/doc']

  validates :reportable_type,  :presence => true
  validates :reportable_id,    :presence => true

  def self.create_attachment_for_sales_report(brand, start_time, end_time = nil)

    #@order_item_ids  = order_items.select(:id).map(&:id)
    #find the prwawnto template you want
    template = File.read("#{RAILS_ROOT}/app/views/admin/document/reports/show.pdf.prawn")

     pdf = Prawn::Document.new()
     pdf.instance_eval do
       #all local variables that the pdf template needs
      # brand = Brand.joins([:variants]).find(brand_id)
       order_items     = OrderItem.where(["order_items.variant_id IN (?) AND order_items.paid_at > ?", brand.variant_ids, start_time])
       @order_items     = end_time ? order_items.where(["order_items.paid_at < ? ", end_time]) : order_items
       eval(template) #this evaluates the template with your variables
     end

    attachment = pdf#.render
  end

  ## call brand.reports.new()
  def save_pdf(pdf, name)#attachment
#    file = StringIO.new(attachment) #mimic a real upload file
#      file.class.class_eval { attr_accessor :document_file_name, :content_type } #add attr's that paperclip needs
#      file.document_file_name = "#{name}-#{I18n.localize(Time.zone.now, :format => :file_us_time)}.pdf"
#      file.content_type = "application/pdf"

    #now just use the file object to save to the Paperclip association.
_filename  = "public/#{name}-#{I18n.localize(Time.zone.now, :format => :file_us_time)}.pdf"
    pdf.render_file(_filename)

    file = File.open(_filename)
    file.class.class_eval { attr_accessor :document_file_name, :content_type }
    file.content_type = "application/pdf"

    # assuming your Paperclip association is named "pdf_report"
    self.document = file
    self.save!
  end
end
