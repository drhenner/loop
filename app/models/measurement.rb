class Measurement < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :presence => true
  SHOE_SIZES  = [5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10,10.5,11,11.5,12,13,14,15,16]
  DRESS_SIZES = [0,1,2,3,4,6,8,10,12,14,16,18]
  WAIST_SIZES = [21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,42,44,46]
  PANT_LENGTHS = [21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,42,44,46]
  SHIRT_SIZES  = ['XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL']
end
