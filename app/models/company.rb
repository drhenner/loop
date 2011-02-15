class Company < ActiveRecord::Base
  has_many :sellers
  has_many :brands
  has_many :images, :as         => :imageable,
                    :order      => :position,
                    :dependent  => :destroy
  has_many :owners
end
