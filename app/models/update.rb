class Update < ActiveRecord::Base

	attr_accessible :title, :content

  	belongs_to :member
	belongs_to :updateable, polymorphic: true

	after_commit :create_notification, on: :create

	validates :title, presence: { message: 'can\'t be blank.'}

  	validates :content, presence: { message: 'can\'t be blank.'}

  	auto_strip_attributes :content
	auto_strip_attributes :title, :squish => true

	def create_notification
		subject = "#{member.user_name}"
		body = "posted a new <b>update</b> <i>\"#{title}\"</i> in <b>#{updateable.name}</b> <p><i>#{content}</i></p>"
		updateable.followers.each{ |follower| follower.notify(subject, body, self) }
	end
end
