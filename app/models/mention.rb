class Mention < ActiveRecord::Base
	attr_accessible :mentioner_id, :mentioner_type, :mentionable_type, :mentionable_id, :status_id, :comment_id

	belongs_to :mentioner, polymorphic: true
    belongs_to :mentionable, polymorphic: true

    after_create :create_notification, :send_email, unless: Proc.new { |mention| mention.mentioner.member.id == mentionable_id }

    def create_notification
		subject = "#{mentioner.member.user_name}"
		body = "<b>mentioned</b> you in a <b>#{mentioner_type.downcase}</b>"
		mentionable.notify(subject, body, self)
	end

	def send_email
	    MentionsMailer.email_notification(mentionable, mentioner, self).deliver
	end

end