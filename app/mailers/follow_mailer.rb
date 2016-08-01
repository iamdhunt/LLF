class FollowMailer < ActionMailer::Base
  default from: "THE COLLECTIVV <noreply@livinglifefearless.co>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.follow_mailer.email_notification.subject
  #

  def email_notification(followable, follower, follow)
    @follower = follower
    @follow = follow

    if follow.followable_type != 'Member'
      @followable = followable.member
    else
      @followable = followable
    end

    if follow.followable_type != 'Member'
      @recipient = followable.member.email
    else
      @recipient = followable.email
    end

    if follow.followable_type != 'Member'
      @type = 'your ' + follow.followable_type.downcase + ': ' + "#{follow.followable.name}"
    else
      @type = 'you'
    end
    mail to: @recipient, subject: "#{follower.full_name} (#{follower.user_name}) is now following #{@type}"
  end
end
