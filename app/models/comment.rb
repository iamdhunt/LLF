class Comment < ActiveRecord::Base
	belongs_to :member
	belongs_to :commentable, polymorphic: true
	attr_accessible :content

	validates :content, presence: true,
				length: { minimum: 2, maximum: 280 }

	after_create :create_notification, on: :create, unless: Proc.new { |comment| comment.member.id == comment.commentable.member.id }
	
	def create_notification
		subject = "#{member.user_name}"
		body = "wrote you a <b>Comment</b> <p><i>#{content}</i></p>"
		commentable.member.notify(subject, body, self)
	end
end
