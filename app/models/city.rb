class City < ActiveRecord::Base

  belongs_to  :state
  has_many    :companies

  validates :name,        :presence => true, :length => { :minimum => 3, :maximum => 100 }
  validates :state_id,    :presence => true
  #validates :latitude,        :presence => true, :length => { :minimum => 3, :maximum => 100 }
  #validates :longitude,       :presence => true, :length => { :minimum => 3, :maximum => 100 }

  def state_name
    state.name
  end
end
