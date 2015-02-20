class Upload < ActiveRecord::Base
   	belongs_to :member
	belongs_to :uploadable, polymorphic: true
	attr_accessible :asset, :caption, :cover

	auto_strip_attributes :caption

	has_attached_file :asset, styles: lambda { |a| a.instance.asset_content_type =~ %r(image) ? {large: "700x700>", medium: "300x200>", list: "188", activity: "300>", small: "260x180>", thumb: "60x60#", av: "200x200#"}  : {} }
	has_attached_file :cover, styles: { media: "188x188#" }

	validates_attachment_presence :asset                    
	validates_attachment_size :asset, :less_than=>15.megabyte
	validates_attachment_content_type :asset, 
									:content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 
										'audio/mp3', 'audio/mpeg', 'audio/mpeg3', 'audio/mpg',
										'audio/x-mp3', 'audio/x-mpeg', 'audio/x-mpeg3', 'audio/x-mpegaudio', 'audio/x-mpg']

	validates_attachment_size :cover, :less_than_or_equal_to=>15.megabyte
  	validates_attachment_content_type :cover, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	after_commit :create_notification, on: :create

	def create_notification
		subject = "#{member.user_name}"
		body = "uploaded new Media in <b>#{uploadable.name}</b>"
		uploadable.followers.each{ |follower| follower.notify(subject, body, self) }
	end								
end
