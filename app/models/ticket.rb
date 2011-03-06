class Ticket < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :brand

  belongs_to  :assigned_to, :class_name   => 'User',
                            :foreign_key  => 'assigned_to_id'
  has_many    :comments,    :dependent  => :destroy,
                            :as         => :commentable

  validates :user_id,       :presence => true
  validates :subject,       :length => { :minimum => 5, :maximum => 255 }
  validates :assigned_to,   :presence => true, :if => :not_new?
  validates :details,       :presence => true, :length => { :minimum => 16, :maximum => 1600 }
  validates :issue_type,    :presence => true

  accepts_nested_attributes_for :comments

  SELLER_TICKET_ISSUE = 'seller_ticket'
  ISSUE_TYPES = [SELLER_TICKET_ISSUE]

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

  def can_destroy?(current_user)
    (self.user_id == current_user.id) || current_user.admin?
  end

  def assigned_name
    assigned_to_id ? assigned_to.name : 'not assigned'
  end

  def inactive!
    update_attribute(:active, false)
  end

  def not_new?
    !new? || status == nil
  end

  def self.summary(brand_ids)
    #:select => "webpages.status, COUNT(webpage_hit.id) AS view_count",
    Ticket.select('tickets.*, COUNT(status) AS view_count').
           where(['tickets.brand_id IN (?)',brand_ids]).
           where(['tickets.active = ?',true]).
           group(:status)
  end
end
