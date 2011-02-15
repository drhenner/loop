class Owner < ActiveRecord::Base

  belongs_to :company
  has_many :images, :as         => :imageable,
                    :order      => :position,
                    :dependent  => :destroy
end
