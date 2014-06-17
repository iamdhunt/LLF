class Update < ActiveRecord::Base
  	belongs_to :member
	belongs_to :updateable, polymorphic: true
	attr_accessible :title, :content

	validates :title, presence: true,
  			length: { minimum: 2, maximum: 60 }

  	validates :content, presence: true,
  			length: { minimum: 2 }

  	after_create :create_notification, on: :create

	def create_notification
		subject = "#{member.user_name}"
		body = "posted a new update <b>#{title}:</b> <p><i>#{content}</i></p>"
		updateable.followers.notify_all(subject, body, self)
	end
end
