class Brand < ActiveRecord::Base
  belongs_to :company
  has_many :variants
  has_many :images, :as         => :imageable,
                    :order      => :position,
                    :dependent  => :destroy

  validates :name,  :presence => true#,
                    #:format   => { :with => CustomValidators::Names.name_validator }
end
