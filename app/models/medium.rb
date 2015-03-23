class Medium < ActiveRecord::Base
  	belongs_to :member

  	attr_accessible :caption, :asset, :cover, :markers, :marker_list

  	has_many :comments, as: :commentable, :dependent => :destroy
  	has_many :activities, as: :targetable, :dependent => :destroy
  	
  	acts_as_votable
  	acts_as_ordered_taggable
  	acts_as_ordered_taggable_on :markers

  	auto_strip_attributes :caption

  	before_create :make_it_permalink
  	before_validation :clean_up_markers

  	has_attached_file :asset, styles: lambda { |a| a.instance.asset_content_type =~ %r(image) ? {large: "700x700>", medium: "300x200>", list: "188", activity: "300>", small: "260x180>", thumb: "60x60#", av: "200x200#"}  : {} }
  	has_attached_file :cover, styles: { activity: "195x195#", media: "188x188#" }

  	validates :marker_list, allow_blank: true,
					length: {
                      maximum: 5,
                      message: '(tags) must not list more than 5 tags.'
                    },
                    format: {
                      with: /^[a-zA-Z0-9 ,-]+$/,
                      message: '(tags) must not include any special characters or numbers.'
                    }
    validate :each_marker

  	validates_attachment_presence :asset                    
	validates_attachment_size :asset, :less_than=>15.megabyte
	validates_attachment_content_type :asset, 
									:content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 
										'audio/mp3', 'audio/mpeg', 'audio/mpeg3', 'audio/mpg',
										'audio/x-mp3', 'audio/x-mpeg', 'audio/x-mpeg3', 'audio/x-mpegaudio', 'audio/x-mpg']

	validates_attachment_size :cover, :less_than_or_equal_to=>15.megabyte
  validates_attachment_content_type :cover, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] 

  searchable :auto_index => true, :auto_remove => true do
      text :marker_list, :boost => 5
      text :caption
      string :marker_list, :multiple => true, :stored => true
    end

	private

		def each_marker
		    marker_list.each do |marker|
		      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
		      errors.add(:marker, "(tag) too long (Maximum is 30 characters)") if marker.length > 30
		    end
	  	end

	  	def clean_up_markers
		    # Make lowercase 
		    self.marker_list.map!(&:downcase) 
		  end

		def make_it_permalink
			# this can create permalink with random 8 digit alphanumeric
			self.permalink = SecureRandom.hex(12)
		end
	
end
