class CommentMailer < ActionMailer::Base
  default from: "THE COLLECTIVV by L&#215;L&#215;F <noreply@livinglifefearless.co>"

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
    if comment.commentable_type != 'Medium'
      @type = comment.commentable_type
    else 
      @type = 'Media'
    end
    mail to: commentable.member.email, subject: "#{comment.member.full_name} (#{comment.member.user_name}) left a comment on your #{@type.downcase}"
  end
end
