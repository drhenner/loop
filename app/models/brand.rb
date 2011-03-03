class Brand < ActiveRecord::Base
  belongs_to :company
  has_many :variants
  has_many :tickets
  has_many :images, :as         => :imageable,
                    :order      => :position,
                    :dependent  => :destroy

  validates :name,  :presence => true#,
                    #:format   => { :with => CustomValidators::Names.name_validator }

  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['photo'].nil? }

  DEFAULT_BRAND_ID = 1

  def self.default_brand_id
    DEFAULT_BRAND_ID
  end
end
