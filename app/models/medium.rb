class Medium < ActiveRecord::Base
  	belongs_to :member
  	attr_accessible :caption, :asset, :cover
  	has_many :comments, as: :commentable, :dependent => :destroy
  	has_many :activities, as: :targetable, :dependent => :destroy
  	acts_as_votable

  	auto_strip_attributes :caption

  	before_create :make_it_permalink

  	has_attached_file :asset, styles: lambda { |a| a.instance.asset_content_type =~ %r(image) ? {large: "700x700>", medium: "300x200>", list: "188", activity: "300>", small: "260x180>", thumb: "60x60#", av: "200x200#"}  : {} }
  	has_attached_file :cover, styles: { activity: "195x195#", media: "188x188#" }

  	validates_attachment_presence :asset                    
	validates_attachment_size :asset, :less_than=>15.megabyte
	validates_attachment_content_type :asset, 
									:content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 
										'audio/mp3', 'audio/mpeg', 'audio/mpeg3', 'audio/mpg',
										'audio/x-mp3', 'audio/x-mpeg', 'audio/x-mpeg3', 'audio/x-mpegaudio', 'audio/x-mpg']

	validates_attachment_size :cover, :less_than_or_equal_to=>15.megabyte
  	validates_attachment_content_type :cover, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] 

	private

	def make_it_permalink
		# this can create permalink with random 8 digit alphanumeric
		self.permalink = SecureRandom.hex(12)
	end
	
end
