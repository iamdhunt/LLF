class Document < ActiveRecord::Base
  	attr_accessible :attachment

 	has_attached_file :attachment, styles: { large: "700x700>", medium: "300x200>", small: "260x180>", thumb: "60x60#", av: "200x200#"}
                   
	validates_attachment_size :attachment, :less_than=>10.megabyte
	validates_attachment_content_type :attachment, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
end
