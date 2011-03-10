class Myaccount::BaseController < ApplicationController
  layout 'my_account'
  before_filter :require_user

  protected

  def ssl_required?
    ssl_supported?
  end
end