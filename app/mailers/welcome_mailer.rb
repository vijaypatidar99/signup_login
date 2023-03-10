class WelcomeMailer < ApplicationMailer
    # sends a welcome email
    def welcome_email
      @user = params[:user]
      @url = 'http://localhost:3000/sign_in'
      mail(to: @user.email, subject: 'Welcome to my website')
    end
  end