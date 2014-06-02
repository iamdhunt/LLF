class Listing < ActiveRecord::Base
  	belongs_to :member

  	attr_accessible :category, :description, :price, :title, :link, :feature, :image, :markers, :marker_list, :assets_attributes

  	validates :title, presence: true
  	validates :link, presence: true
  	validates :feature, presence: true
  	validates :category, presence: true,
  						inclusion: {
  							in: %w(Men's Women's Art Music Design Services)
  						}
  	validates :marker_list, presence: true,
  						length: {
                              maximum: 5,
                              message: 'must not list more than 5 tags.'
                            },
                            format: {
                              with: /^[a-zA-Z ,-]+$/,
                              message: 'must be formatted correctly.'
                            }
    validates :price, presence: true,
    					length: {
                              maximum: 10
                            },
                            format: {
                              with: /^[0-9 ,.]+$/,
                              message: 'must be formatted correctly.'
                            }

    before_validation :clean_up_markers
    before_validation :strip_commas_from_price

  	has_attached_file :feature, styles: { large: "700x700>", feature: "380x380#", activity: "300>", thumb: "30x30#", index: "230x230#", list: "230x230#" }
  	has_attached_file :image, styles: { list: "100x100#" }

 	  validates_attachment_size :feature, :less_than_or_equal_to=>10.megabyte
  	validates_attachment_content_type :feature, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	validates_attachment_size :image, :less_than_or_equal_to=>10.megabyte
  	validates_attachment_content_type :image, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']                       

  	acts_as_votable
  	acts_as_ordered_taggable
  	acts_as_ordered_taggable_on :markers
  	has_many :comments, as: :commentable
    has_many :assets

    accepts_nested_attributes_for :assets, :allow_destroy => true

  	private

	  def each_marker
	    marker_list.each do |marker|
	      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
	      errors.add(:marker, "Too long (Maximum is 15 characters)") if marker.length > 15
	    end
	  end

	  def clean_up_markers
	    # Make lowercase 
	    self.marker_list.map!(&:downcase) 
	  end

	  def strip_commas_from_price
		self.price = self.price.to_s.gsub(/,/, '').to_f
	  end

end
