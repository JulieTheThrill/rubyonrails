class ModelMailer < ActionMailer::Base
  default from: "jgill@walkingthenrunning.herokuapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.forgot_password.subject
  #
  def forgot_password(user)
    @user = user

    mail to: user.email, subject: "Password Reset Instructions"
  end
end
