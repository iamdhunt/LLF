class Update < ActiveRecord::Base
  	belongs_to :member
	belongs_to :updateable, polymorphic: true
	attr_accessible :title, :content

	auto_strip_attributes :content
	auto_strip_attributes :title, :squish => true

	validates :title, presence: true,
  			length: { minimum: 2, maximum: 60 }

  	validates :content, presence: true,
  			length: { minimum: 2 }

  	after_commit :create_notification, on: :create

  	auto_html_for :content do
	    image
	    youtube(:width => 660, :height => 400, :autoplay => false)
	    vimeo(:width => 660, :height => 400, :autoplay => false)
	    simple_format
	end

	def create_notification
		subject = "#{member.user_name}"
		body = "posted a new <b>update</b> <i>\"#{title}\"</i> in <b>#{updateable.name}</b> <p><i>#{content}</i></p>"
		updateable.followers.each{ |follower| follower.notify(subject, body, self) }
	end
end
