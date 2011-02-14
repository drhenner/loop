class Feedback < ActiveRecord::Base
  include Rakismet::Model

  rakismet_attrs :author        => :name,
                 :author_email  => :email,
                 :author_url    => :website

  validates :title,   :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :user_ip, :presence => true
  validates :name,    :presence => true
  validates :email,   :presence => true

  DEFAULT_USER_ID = 3

  def not_spam?
    !spam?
  end
end
