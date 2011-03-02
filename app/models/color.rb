class Color < ActiveRecord::Base

  has_many :variants

  has_many :product_colors
  has_many :products,          :through => :product_colors

  RED     = 'red'
  ORANGE  = 'orange'
  YELLOW  = 'yellow'
  GREEN   = 'green'
  BLUE    = 'blue'
  VIOLET  = 'violet'
  BLACK   = 'black'
  WHITE   = 'white'
  BROWN   = 'brown'
  GREY    = 'grey'

  TYPES   = [RED, ORANGE, YELLOW, GREEN, BLUE, VIOLET, BLACK, WHITE, BROWN, GREY]

  DEFAULT_COLOR_TYPE    = RED
  DEFAULT_COLOR_TYPE_ID = 1

  DEFAULT_COLOR = '#E8E8E8'

  validates :name,  :presence => true

  def display_css_color
    css_color? ? css_color : DEFAULT_COLOR
  end

  def self.default_color_id
    DEFAULT_COLOR_TYPE_ID
  end
end
