class PasswordResetsController < ApplicationController
    def new; end
    def edit
      # finds user with a valid token
      @user = User.find_signed!(params[:token], purpose: 'password_reset')
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to sign_in_path, alert: 'Your token has expired. Please try again.'
    end


    def create
        @user = User.find_by(email: params[:email])
        if @user.present?
          # send mail
          PasswordMailer.with(user: @user).reset.deliver_later
          # deliver_later is provided by ActiveJob
        end
        
        redirect_to sign_in_path 

    def update
      # updates user's password
      @user = User.find_signed!(params[:token], purpose: 'password_reset')
      if @user.update(password_params)
        redirect_to sign_in_path, notice: 'Your password was reset successfully. Please sign in'
        else
        render :edit
      end
    end



    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end