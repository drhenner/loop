class Company < ActiveRecord::Base
  has_many :sellers
  has_many :brands
  has_many :images, :as         => :imageable,
                    :order      => :position,
                    :dependent  => :destroy
  has_many :owners

  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['photo'].nil? }
end
