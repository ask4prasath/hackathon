class UserMailer < ActionMailer::Base
  default from: "ask4prasath@gmail.com"
  default reply_to: 'support@guardstreet.com'

  def welcome_email(user)
    @user = user
    mail( :to       => user.email,
          :subject  => 'Welcome to Rhea')
  end
end
