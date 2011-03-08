class FeaturedItem < ActiveRecord::Base

  belongs_to :product

  validates :product_id,  :presence => true
  validates :starts_at,   :presence => true

  after_save :set_previous_ends_at

  def product_name
    product.name
  end

  def self.now
    self.at
  end

  def self.at(item_at = Time.zone.now)
    where(['featured_items.starts_at < ?', item_at ]).order('featured_items.starts_at DESC').limit(1)
  end

  private

  def set_previous_ends_at
    item = FeaturedItem.at(self.starts_at).first
    item.update_attribute(:ends_at, self.starts_at) if item
  end
end
