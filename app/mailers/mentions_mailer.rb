class MentionsMailer < ActionMailer::Base
  default from: "LLF <noreply@livinglifefearless.co>"

  def email_notification(mentionable, mentioner, mention)
    @member = mentionable
    @sender = mention.mentioner.member
    @mention = mention
    @mentioner = mention.mentioner

    if mention.mentioner_type == 'Medium' || mention.mentioner_type == 'Upload'
      @content = mention.mentioner.caption
    else
      @content = mention.mentioner.content
    end

    if mention.mentioner_type == 'Medium'
      @type = "caption"
    elsif mention.mentioner_type == 'Upload'
      @type = mention.mentioner.uploadable_type.downcase + ' ' + mention.mentioner_type.downcase + ' for ' + mention.mentioner.uploadable.name.upcase
    else
      @type = mention.mentioner_type
    end

    if mention.mentioner_type == 'Medium' 
    	@mention_link = mention.mentioner
    elsif mention.mentioner_type == 'Upload'
      @mention_link = mention.mentioner.uploadable
    else
    	@mention_link = mention.mentioner.commentable
    end 

    mail to: mentionable.email, subject: "#{mention.mentioner.member.full_name} (#{mention.mentioner.member.user_name}) mentioned you in a #{@type.downcase}"
  end
end
