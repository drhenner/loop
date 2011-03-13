class Report < ActiveRecord::Base
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
end
