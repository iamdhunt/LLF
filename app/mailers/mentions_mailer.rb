class MentionsMailer < ActionMailer::Base
  default from: "LLF <noreply@livinglifefearless.co>"

  def email_notification(mentionable, mentioner, mention)
    @member = mentionable
    @sender = mention.mentioner.member
    @mention = mention
    @mentioner = mention.mentioner
    @type = mention.mentioner_type
    if mention.mentioner_type == 'Status' 
    	@mention_link = mention.mentioner
    elsif mention.mentioner_type == 'Comment'
    	@mention_link = mention.mentioner.commentable
    end 
    mail to: mentionable.email, subject: "#{mention.mentioner.member.full_name} (#{mention.mentioner.member.user_name}) mentioned you in a #{mention.mentioner_type.downcase}"
  end
end
