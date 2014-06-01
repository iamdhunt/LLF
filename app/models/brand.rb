class Brand < ActiveRecord::Base
	belongs_to :member

	attr_accessible :name, :description, :markers, :marker_list, :logo, :banner
	validates :name, presence: true
  validates :description, presence: true
	validates :description, allow_blank: true,
  						length: {
                          maximum: 140, 
                          message: 'must not be more than 140 characters.'
                        }
    validates :marker_list, presence: true,
  						length: {
                              maximum: 3,
                              message: 'must not list more than 3 tags.'
                            },
                            format: {
                              with: /^[a-zA-Z ,-]+$/,
                              message: 'must be formatted correctly.'
                            }
    validate :each_marker

    acts_as_votable
    acts_as_ordered_taggable
  	acts_as_ordered_taggable_on :markers
    has_many :listings

  	has_attached_file :logo, styles: {activity: "300>", thumb: "30x30#", av: "165x165#", list: "110x110#"},
  								:default_url => '/assets/Products Default.png'
  	has_attached_file :banner, styles: { large: "1400x200<", preview: "600x200>" },
  								:default_url => '/assets/Market Default Banner.png'

 	  validates_attachment_size :logo, :less_than_or_equal_to=>10.megabyte
  	validates_attachment_content_type :logo, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	validates_attachment_size :banner, :less_than_or_equal_to=>10.megabyte
  	validates_attachment_content_type :banner, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

    searchable :auto_index => true, :auto_remove => true do
      text :name, :boost => 5
      text :marker_list, :boost => 2
      string :marker_list, :multiple => true, :stored => true
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

end
