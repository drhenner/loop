class Myaccount::BaseController < ApplicationController
  layout 'my_account'

  protected

  def ssl_required?
    ssl_supported?
  end
end