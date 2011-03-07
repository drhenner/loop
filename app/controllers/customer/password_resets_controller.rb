class Customer::PasswordResetsController < ApplicationController

    before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

    def new
      @user = User.new
      #render
    end

    def create
        @user = User.find_by_email(params[:user][:email])
        if @user
          @user.deliver_password_reset_instructions!
          flash[:notice] = 'Instructions to reset your password have been emailed.'
          render :template => '/customer/password_resets/confirmation'
        else
          @user = User.new
          flash[:notice] = 'No user was found with that email address'
          render :action => 'new'
        end
    end

    def edit
      #render
    end

    def update
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        #@user.activate!
        flash[:notice] = 'Your password has been reset'
        redirect_to login_url
      else
        render :action => :edit
      end
    end

    protected

    def load_user_using_perishable_token
      @user = User.find_by_perishable_token( params[:id])
    end

end
