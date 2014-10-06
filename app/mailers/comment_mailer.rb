class CommentMailer < ActionMailer::Base
  default from: "LLF <noreply@livinglifefearless.co>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.email_notification.subject
  #
  def email_notification(member, commentable, comment)
    @member = commentable.member
    @sender = comment.member
    @comment = comment
    @commentable = commentable
    mail to: commentable.member.email, subject: "#{comment.member.full_name} (#{comment.member.user_name}) has left you a comment"
  end
end
