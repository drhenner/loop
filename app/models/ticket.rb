class Ticket < ActiveRecord::Base
  belongs_to :user_id
  belongs_to :brand_id

  belongs_to :assigned_to, :class_name => 'User', :foreign_key => 'assigned_to_id'


  validates :user_id,       :presence => true
  validates :subject,       :length => { :maximum => 255 }
  validates :assigned_to,   :presence => true, :if => :not_new?
  validates :details,       :presence => true, :length => { :maximum => 1600 }
  validates :issue_type,    :presence => true

  state_machine :status, :initial => 'new' do

    event :assign do
      transition :to => 'assigned', :from => 'new'
    end

    event :resolve do
      transition :to => 'resolved', :from => ['assigned', 'new']
    end

    event :cancel do
      transition :to => 'canceled', :from => ['assigned', 'new', 'resolved']
    end
    #before_transition :to => 'shipped', :do => [:set_to_shipped]
    #after_transition :to => 'shipped', :do => [:ship_inventory, :mark_order_as_shipped]
  end

  def not_new?
    !new?
  end
end
