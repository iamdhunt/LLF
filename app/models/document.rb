class Document < ActiveRecord::Base
  	attr_accessible :attachment, :remove_attachment

  	attr_accessor :remove_attachment

  	has_one :status

 	has_attached_file :attachment, styles: { large: "700x700>", medium: "300x200>", activity: "300>", small: "260x180>", thumb: "60x60#", av: "200x200#"}
                   
	validates_attachment_size :attachment, :less_than=>10.megabyte, message: '(image attachment) must be less than or equal to 10mb.'
	validates_attachment_content_type :attachment, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
													message: 'must be a .jpeg, .jpg, or .png file type.'

	before_save :perform_attachment_removal

	def perform_attachment_removal
	    if remove_attachment == '1' && !attachment.dirty?
	      self.attachment = nil
	    end
	end

end
