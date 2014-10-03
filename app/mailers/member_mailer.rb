class MemberMailer < ActionMailer::Base
  default from: "LLF <noreply@livinglifefearless.co>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.signup_confirmation.subject
  #
  def signup_confirmation(member)
    @member = member

    mail to: member.email, subject: "Welcome to the community!"
  end
end
