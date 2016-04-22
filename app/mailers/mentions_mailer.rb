class MentionsMailer < ActionMailer::Base
  default from: "LLF <noreply@livinglifefearless.co>"

  def email_notification(mentionable, mentioner, mention)
    @member = mentionable
    @sender = mention.mentioner.member
    @mention = mention
    @mentioner = mention.mentioner

    if mention.mentioner_type == 'Medium' || mention.mentioner_type == 'Upload'
      @content = mention.mentioner.caption
    elsif mention.mentioner_type == 'Project'
      @content = mention.mentioner.about
    elsif mention.mentioner_type == 'Event'
      @content = mention.mentioner.details
    elsif mention.mentioner_type == 'Listing'
      @content = mention.mentioner.description
    else
      @content = mention.mentioner.content
    end

    if mention.mentioner_type == 'Medium'
      @type = "caption"
    elsif mention.mentioner_type == 'Upload'
      @type = mention.mentioner.uploadable_type.downcase + ' ' + mention.mentioner_type.downcase + ' for ' + mention.mentioner.uploadable.name
    elsif mention.mentioner_type == 'Update'
      @type = mention.mentioner.updateable_type.downcase + ' update for ' + mention.mentioner.updateable.name
    elsif mention.mentioner_type == 'Project' || mention.mentioner_type == 'Event'
      @type = mention.mentioner_type.downcase + ' ' + mention.mentioner.name
    else
      @type = mention.mentioner_type
    end

    if mention.mentioner_type == 'Medium' || mention.mentioner_type == 'Project' || mention.mentioner_type == 'Event' || mention.mentioner_type == 'Status' || mention.mentioner_type == 'Listing' 
    	@mention_link = mention.mentioner
    elsif mention.mentioner_type == 'Upload'
      @mention_link = mention.mentioner.uploadable
    elsif mention.mentioner_type == 'Update'
      @mention_link = mention.mentioner.updateable
    else
    	@mention_link = mention.mentioner.commentable
    end 

    mail to: mentionable.email, subject: "#{mention.mentioner.member.full_name} (#{mention.mentioner.member.user_name}) mentioned you in a #{@type.downcase}"
  end
end
