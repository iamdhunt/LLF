class Document < ActiveRecord::Base
  	attr_accessible :attachment

 	has_attached_file :attachment, styles: { large: "700x700>", medium: "300x200>", activity: "300>", small: "260x180>", thumb: "60x60#", av: "200x200#"}
                   
	validates_attachment_size :attachment, :less_than=>10.megabyte, message: '(image attachment) must be less than or equal to 10mb.'
	validates_attachment_content_type :attachment, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
													message: 'must be a .jpeg, .jpg, .png, or .gif file type.'
end
