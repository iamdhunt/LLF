class Medium < ActiveRecord::Base
  	belongs_to :member
  	attr_accessible :caption, :asset

  	has_attached_file :asset, styles: { large: "700x700>", medium: "300x200>", list: "300", small: "260x180>", thumb: "60x60#", av: "200x200#"}

  	validates_attachment_presence :asset                    
	validates_attachment_size :asset, :less_than=>10.megabyte
	validates_attachment_content_type :asset, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] 
end
