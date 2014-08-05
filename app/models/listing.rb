class Listing < ActiveRecord::Base
  	belongs_to :member

    before_create :make_it_permalink

  	attr_accessible :category, :description, :price, :title, :link, :feature, :markers, :marker_list, :assets_attributes, :cover

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
                              message: 'must not include any special characters or numbers.'
                            }
    validates :price, presence: true,
    					length: {
                              maximum: 10
                            },
                            format: {
                              with: /^[0-9 ,.]+$/,
                              message: 'must not include any special characters or letters.'
                            }

    before_validation :clean_up_markers
    before_validation :strip_commas_from_price

  	has_attached_file :feature, styles: lambda { |a| a.instance.feature_content_type =~ %r(image) ? { large: "700x700>", feature: "380x380#", activity: "300>", thumb: "30x30#", index: "230x230#", list: "230x230#", additional: "100x100#" } : {} }
    has_attached_file :cover, styles: { cover: "230x230#", small: "100x100#" }

 	  validates_attachment_size :feature, :less_than_or_equal_to=>15.megabyte
  	validates_attachment_content_type :feature, 
                                      :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 
                                            'audio/mp3', 'audio/mpeg', 'audio/mpeg3', 'audio/mpg',
                                            'audio/x-mp3', 'audio/x-mpeg', 'audio/x-mpeg3', 'audio/x-mpegaudio', 'audio/x-mpg']                       

    validates_attachment_size :cover, :less_than_or_equal_to=>15.megabyte
    validates_attachment_content_type :cover, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	acts_as_votable
  	acts_as_ordered_taggable
  	acts_as_ordered_taggable_on :markers
  	has_many :comments, as: :commentable, :dependent => :destroy
    has_many :assets, :dependent => :destroy
    has_many :activities, as: :targetable, :dependent => :destroy

    accepts_nested_attributes_for :assets, :allow_destroy => true

    searchable :auto_index => true, :auto_remove => true do
      text :title, :boost => 5
      text :marker_list, :boost => 2
      text :category
      string :marker_list, :multiple => true, :stored => true
      float :price
    end

    def to_param
      "#{id}-#{title.parameterize}"
    end

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

    def make_it_permalink
      # this can create permalink with random 8 digit alphanumeric
      self.permalink = SecureRandom.hex(12)
    end

end
