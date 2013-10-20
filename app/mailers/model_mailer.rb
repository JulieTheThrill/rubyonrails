class ModelMailer < ActionMailer::Base
  default from: "julie@walkingthenrunning.herokuapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.forgot_password.subject
  #
  def forgot_password(email)
    @greeting = "Hi"

    mail to: email, subject: "You forgot your password?"
  end
end
