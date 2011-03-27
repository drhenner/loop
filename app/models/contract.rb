class Contract < ActiveRecord::Base
  belongs_to :brand

  validates :brand_id,      :presence => true
  validates :start_date,    :presence => true
  validates :store_percent, :presence => true
  validates :flash_percent, :presence => true

  def seller_percentage(variant)
    case variant.product_type
    when 'flash'
      100.0 - flash_percent
    else
      100.0 - store_percent
    end
  end

end
