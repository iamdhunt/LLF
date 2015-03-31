class Mention < ActiveRecord::Base
	attr_accessible :mentioner_id, :mentioner_type, :mentionable_type, :mentionable_id, :status_id, :comment_id

	belongs_to :mentioner, polymorphic: true
    belongs_to :mentionable, polymorphic: true


    def create_notification
		subject = "#{mentioner.member.user_name}"
		body = "<b>mentioned</b> you in a #{mentioner_type} <p><i>#{mentioner.content}</i></p>"
		mention.mentionable.notify(subject, body, self)
	end

end