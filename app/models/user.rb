class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
#  devise :database_authenticatable, :registerable, :confirmable,
#         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #include ActiveMerchant::Utils
  include UserCim

  acts_as_authentic do |config|
    config.validate_email_field
    config.validates_length_of_password_field_options( :minimum => 6, :on => :update, :if => :password_changed? )

    # So that Authlogic will not use the LOWER() function when checking login, allowing for benefit of column index.
    config.validates_uniqueness_of_login_field_options :case_sensitive => true
    config.validates_uniqueness_of_email_field_options :case_sensitive => true

    config.validate_login_field = true;
    config.validate_email_field = true;

    # Remove unecessary field validation given by Authlogic.
    #config.validate_password_field = false;

  end

  before_validation :sanitize_data, :before_validation_on_create
  before_create :start_store_credits
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :openid_identifier, :birth_date, :role_ids, :address_attributes, :phone_attributes

  belongs_to :account
  belongs_to :company

  has_one     :store_credit
  has_one     :measurement

  has_many    :tickets
  has_many    :assigned_tickets, :class_name => 'Ticket', :foreign_key => 'assigned_to_id'

  has_many    :orders
  has_many    :completed_orders,          :class_name => 'Order',
                                          :conditions => {:orders => { :state => 'complete'}}

  has_many    :phones,                    :dependent => :destroy,
                                          :as => :phoneable

  has_one     :primary_phone,             :conditions => {:phones => { :primary => true}},
                                          :as => :phoneable,
                                          :class_name => 'Phone'

  has_many    :addresses,                 :dependent => :destroy,
                                          :as => :addressable

  has_one     :default_billing_address,   :conditions => {:addresses => { :billing_default => true, :active => true}},
                                          :as => :addressable,
                                          :class_name => 'Address'

  has_many    :billing_addresses,         :conditions => {:addresses => { :active => true}},
                                          :as => :addressable,
                                          :class_name => 'Address'

  has_one     :default_shipping_address,  :conditions => {:addresses => { :default => true, :active => true}},
                                          :as => :addressable,
                                          :class_name => 'Address'

  has_many     :shipping_addresses,       :conditions => {:addresses => { :active => true}},
                                          :as => :addressable,
                                          :class_name => 'Address'

  has_many    :user_roles,                :dependent => :destroy
  has_many    :roles,                     :through => :user_roles

  has_many    :carts,                     :dependent => :destroy

  has_many    :cart_items
  has_many    :shopping_cart_items,       :conditions => {:cart_items => { :active        => true,
                                                                           :item_type_id  => ItemType::SHOPPING_CART_ID}},
                                          :class_name => 'CartItem'

  has_many    :wish_list_items,           :conditions => {:cart_items => { :active        => true,
                                                                           :item_type_id  => ItemType::WISH_LIST_ID}},
                                          :class_name => 'CartItem'

  has_many    :saved_cart_items,           :conditions => {:cart_items => { :active        => true,
                                                                            :item_type_id  => ItemType::SAVE_FOR_LATER}},
                                          :class_name => 'CartItem'

  has_many    :purchased_items,           :conditions => {:cart_items => { :active        => true,
                                                                           :item_type_id  => ItemType::PURCHASED_ID}},
                                          :class_name => 'CartItem'

  has_many    :deleted_cart_items,        :conditions => {:cart_items => { :active => false}}, :class_name => 'CartItem'
  has_many    :payment_profiles
  has_many    :transaction_ledgers, :as => :accountable

  has_many    :return_authorizations
  has_many    :authored_return_authorizations, :class_name => 'ReturnAuthorization', :foreign_key => 'author_id'

  validates :first_name,  :presence => true, :if => :registered_user?,
                          :format   => { :with => CustomValidators::Names.name_validator },
                          :length => { :maximum => 30 }
  validates :last_name,   :presence => true, :if => :registered_user?,
                          :format   => { :with => CustomValidators::Names.name_validator },
                          :length => { :maximum => 35 }
  validates :email,       :presence => true,
                          :uniqueness => true,##  This should be done at the DB this is too expensive in rails
                          :format   => { :with => CustomValidators::Emails.email_validator },
                          :length => { :maximum => 255 }
  #validates :password,    :presence => { :if => :password_required? }, :confirmation => true

  accepts_nested_attributes_for :addresses, :phones, :user_roles

  state_machine :state, :initial => :inactive do
    state :inactive
    state :active
    state :unregistered
    state :registered
    state :registered_with_credit
    state :canceled

    event :activate do
      transition :from => :inactive,    :to => :active
    end

    event :register do
      #transition :to => 'registered', :from => :all
      transition :from => :active,                 :to => :registered
      transition :from => :inactive,               :to => :registered
      transition :from => :unregistered,           :to => :registered
      transition :from => :registered_with_credit, :to => :registered
      transition :from => :canceled,               :to => :registered
    end

    event :cancel do
      transition :from => any, :to => :canceled
    end

  end

  # returns true or false if the user is active or not
  #
  # @param [none]
  # @return [ Boolean ]
  def active?
    !['canceled', 'inactive'].any? {|s| self.state == s }
  end

  # in plain english returns 'true' or 'false' if the user is active or not
  #
  # @param [none]
  # @return [ String ]
  def display_active
    active?.to_s
  end

  # returns true or false if the user has a role or not
  #
  # @param [String] role name the user should have
  # @return [ Boolean ]
  def role?(role_name)
    roles.any? {|r| r.name == role_name.to_s}
  end

  # returns true or false if the user is an admin or not
  #
  # @param [none]
  # @return [ Boolean ]
  def admin?
    role?(:administrator) || role?(:super_administrator)
  end

  # returns true or false if the user is a super admin or not
  # FYI your IT staff might be an admin but your CTO and IT director is a super admin
  #
  # @param [none]
  # @return [ Boolean ]
  def super_admin?
    role?(:super_administrator)
  end

  # returns true or false if the user is an seller_admin or not
  #
  # @param [none]
  # @return [ Boolean ]
  def seller_admin?
    role?(:seller_admin) || role?(:administrator) || role?(:super_administrator)
  end

  # returns your last cart or nil
  #
  # @param [none]
  # @return [ Cart ]
  def current_cart
    carts.last
  end

  # formats the String
  #
  # @param [String] formatted in Euro-time
  # @return [ none ]  sets birth_date for the user
  def format_birth_date(b_date)
    self.birth_date = Date.strptime(b_date, "%m/%d/%Y") if b_date.present?
  end

  def display_birth_date
    self.birth_date? ? self.birth_date.strftime("%m/%d/%Y") : 'N/A'
  end

  ##  This method will one day grow into the products a user most likely likes.
  #   Storing a list of product ids vs cron each night might be the most efficent mode for this method to work.
  def might_be_interested_in_these_products
    Product.limit(4).find(:all)
  end

  # Returns the default billing address if it exists.   otherwise returns the shipping address
  #
  # @param [none]
  # @return [ Address ]
  def billing_address
    default_billing_address ? default_billing_address : shipping_address
  end

  # Returns the default shipping address if it exists.   otherwise returns the first shipping address
  #
  # @param [none]
  # @return [ Address ]
  def shipping_address
    default_shipping_address ? default_shipping_address : shipping_addresses.first
  end

  # returns true or false if the user is a registered user or not
  #
  # @param [none]
  # @return [ Boolean ]
  def registered_user?
    registered? || registered_with_credit?
  end

  # gives the user's first and last name if available, otherwise returns the users email
  #
  # @param [none]
  # @return [ String ]
  def name
    (first_name? && last_name?) ? [first_name.capitalize, last_name.capitalize ].join(" ") : email
  end

  # gives the user's comany name or ''
  #
  # @param [none]
  # @return [ String ]
  def company_name
    (company_id) ? company.name  : ''
  end

  # sanitizes the saving of data.  removes white space and assigns a free account type if one doesn't exist
  #
  # @param  [ none ]
  # @return [ none ]
  def sanitize_data
    self.email      = self.email.strip.downcase       unless email.blank?
    self.first_name = self.first_name.strip.capitalize  unless first_name.nil?
    self.last_name  = self.last_name.strip.capitalize   unless last_name.nil?

    ## CHANGE THIS IF YOU HAVE DIFFERENT ACCOUNT TYPES
    unless account_id
      self.account = Account.first
    end
  end

  # email activation instructions after a user signs up
  #
  # @param  [ none ]
  # @return [ none ]
  def deliver_activation_instructions!
    Notifier.signup_notification(self).deliver
  end

  # name and email string for the user
  # ex. '"John Wayne" "jwayne@badboy.com"'
  #
  # @param  [ none ]
  # @return [ String ]
  def email_address_with_name
    "\"#{name}\" <#{email}>"
  end

  # place holder method for creating cim profiles for recurring billing
  #
  # @param  [ none ]
  # @return [ String ] CIM id returned from the gateway
  def get_cim_profile
    return customer_cim_id if customer_cim_id
    create_cim_profile
    customer_cim_id
  end

  # name and first line of address (used by credit card gateway to descript the merchant)
  #
  # @param  [ none ]
  # @return [ String ] name and first line of address
  def merchant_description
    [name, default_shipping_address.try(:address_lines)].compact.join(', ')
  end

  # Find users that have signed up for the subscription
  #
  # @params [ none ]
  # @return [ Arel ]
  def self.find_subscription_users
    where('account_id NOT IN (?)', Account::FREE_ACCOUNT_IDS )
  end

  # include addresses in Find
  #
  # @params [ none ]
  # @return [ Arel ]
  def include_default_addresses
    includes([:default_billing_address, :default_shipping_address, :account])
  end

  # paginated results from the admin User grid
  #
  # @param [Optional params]
  # @return [ Array[User] ]
  def self.admin_grid(params = {})

    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]

    grid = User
    grid = grid.includes(:roles)
    grid = grid.where("users.first_name LIKE ?", "%#{params[:first_name]}%") if params[:first_name].present?
    grid = grid.where("users.last_name LIKE ?",  "%#{params[:last_name]}%")  if params[:last_name].present?
    grid = grid.where("users.email LIKE ?",      "%#{params[:email]}%")      if params[:email].present?
    grid = grid.order("#{params[:sidx]} #{params[:sord]}")
    grid.paginate({:page => params[:page],:per_page => params[:rows]})
  end

  # results from the seller_admin's products
  #
  # @param [none]
  # @return [ Array[Product] ] Array of seller's products
  def seller_products(params = {})
    params[:page] ||= 1
    params[:rows] ||= 20
    all_seller_products.paginate({:page => params[:page],:per_page => params[:rows]})
  end

  # results from the seller_admin's products
  #
  # @param [none]
  # @return [ Array[Product] ] Array of seller's products
  def all_seller_products
    if company_id
      Product.includes(:variants).where(["variants.brand_id IN (?)", company.brand_ids] )
    elsif admin?
      Product.includes(:variants)
    end
  end

  # results from the seller_admin's orders
  #
  # @param [none]
  # @return [ Array[Order] ] Array of seller's products
  def seller_orders(params = nil, id = nil)
    if company_id
      o = Order.includes([{:order_items => :variant} ]).where(["variants.brand_id IN (?)", company.brand_ids] )
      o = o.paginate({:page => params[:page],:per_page => params[:rows]}) if params
    elsif admin?
      o = Order.includes(:order_items)
      o = o.paginate({:page => params[:page],:per_page => params[:rows]}) if params
    end
    o = o.find(id) if id
    o
  end

  def brand_ids
    if company_id
      company.brand_ids
    elsif admin?
      Brand.select(:id).all
    end
  end

  private

  def start_store_credits
    self.store_credit = StoreCredit.new(:amount => 0.0, :user => self)
  end

  def password_required?
    self.crypted_password.blank?
  end

  #def create_cim_profile
  #  return true if customer_cim_id
  #  #Login to the gateway using your credentials in environment.rb
  #  @gateway = GATEWAY
  #
  #  #setup the user object to save
  #  @user = {:profile => user_profile}
  #
  #  #send the create message to the gateway API
  #  response = @gateway.create_customer_profile(@user)
  #
  #  if response.success? and response.authorization
  #    update_attributes({:customer_cim_id => response.authorization})
  #    return true
  #  end
  #  return false
  #end

  def user_profile
    return {:merchant_customer_id => self.id, :email => self.email, :description => self.merchant_description}
  end

  def before_validation_on_create
    self.access_token = ActiveSupport::SecureRandom::hex(9+rand(6)) if self.new_record? and self.access_token.nil?
  end
end
