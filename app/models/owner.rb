class Owner < ActiveRecord::Base

  belongs_to :company
  has_many :images, :as         => :imageable,
                    :order      => :position,
                    :dependent  => :destroy

  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['photo'].nil? }
end
