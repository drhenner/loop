class Contract < ActiveRecord::Base
  belongs_to :brand

  validates :brand_id,      :presence => true
  validates :start_date,    :presence => true
  validates :store_percent, :presence => true
  validates :flash_percent, :presence => true

end
