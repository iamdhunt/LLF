class Medium < ActiveRecord::Base
  	belongs_to :member
  	attr_accessible :caption, :asset
  	has_many :comments, as: :commentable
  	acts_as_votable

  	has_attached_file :asset, styles: lambda { |a| a.instance.asset_content_type =~ %r(image) ? {large: "700x700>", medium: "300x200>", list: "188", activity: "300>", small: "260x180>", thumb: "60x60#", av: "200x200#"}  : {} }
  	has_attached_file :audio

  	validates_attachment_presence :asset                    
	validates_attachment_size :asset, :less_than=>10.megabyte
	validates_attachment_size :audio, :less_than=>10.megabyte
	validates_attachment_content_type :asset, 
									:content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 
										'audio/mp3', 'audio/mpeg', 'audio/mpeg3', 'audio/mpg',
										'audio/x-mp3', 'audio/x-mpeg', 'audio/x-mpeg3', 'audio/x-mpegaudio', 'audio/x-mpg'] 
	validates_attachment_content_type :audio, :content_type=>['audio/mp3']
	
end
