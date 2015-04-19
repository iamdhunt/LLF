class Asset < ActiveRecord::Base
	
  belongs_to :member
  belongs_to :listing

  attr_accessible :asset

  has_attached_file :asset, styles: { large: "700x700>", thumb: "100x100#" }

  validates_attachment_size :asset, :less_than_or_equal_to=>10.megabyte, message: 'must be less than or equal to 10mb.'
  validates_attachment_content_type :asset, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
  											message: 'must be a .jpeg, .jpg, .png, or .gif file type.'

end
