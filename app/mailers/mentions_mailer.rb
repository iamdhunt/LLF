class MentionsMailer < ActionMailer::Base
  default from: "LLF <noreply@livinglifefearless.co>"

  def email_notification(mentionable, mentioner, mention)
    @member = mentionable
    @sender = mention.mentioner.member
    @mention = mention
    @mentioner = mention.mentioner

    if mention.mentioner_type == 'Medium'
      @content = mention.mentioner.caption
    else
      @content = mention.mentioner.content
    end

    if mention.mentioner_type == 'Medium'
      @type = "caption"
    else
      @type = mention.mentioner_type
    end

    if mention.mentioner_type != 'Comment' 
    	@mention_link = mention.mentioner
    else
    	@mention_link = mention.mentioner.commentable
    end 

    mail to: mentionable.email, subject: "#{mention.mentioner.member.full_name} (#{mention.mentioner.member.user_name}) mentioned you in a #{@type.downcase}"
  end
end
