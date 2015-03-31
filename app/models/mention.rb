class Mention < ActiveRecord::Base
	attr_accessible :status_id, :comment_id, :member_id, :mentionable_type, :mentionable_id

    belongs_to :mentionable, polymorphic: true

    def create_notification
		subject = "#{mentionable.member.user_name}"
		body = "has <b>mentioned</b> you in a #{mentionable.type} <p><i>#{mentionable.content}</i></p>"
		commentable.member.notify(subject, body, self)
	end
end