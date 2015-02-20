class Comment < ActiveRecord::Base
	belongs_to :member
	belongs_to :commentable, polymorphic: true
	attr_accessible :content

	validates :content, presence: true,
				length: { minimum: 2, maximum: 280 }

	after_create :send_email, :create_notification, on: :create, unless: Proc.new { |comment| comment.member.id == comment.commentable.member.id }
	
	auto_strip_attributes :content

	def create_notification
		subject = "#{member.user_name}"
		body = "wrote you a <b>Comment</b> <p><i>#{content}</i></p>"
		commentable.member.notify(subject, body, self)
	end

	def send_email
	    CommentMailer.email_notification(member, commentable, self).deliver
	end
end
