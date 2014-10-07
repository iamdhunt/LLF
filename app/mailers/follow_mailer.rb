class FollowMailer < ActionMailer::Base
  default from: "LLF <noreply@livinglifefearless.co>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.follow_mailer.email_notification.subject
  #
  def email_notification(followable, follower, follow)
    @follower = follower
    @follow = follow
    @followable = followable
    mail to: followable.email, subject: "#{follower.full_name} (#{follower.user_name}) is now following you"
  end
end
