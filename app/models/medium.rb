class Medium < ActiveRecord::Base

  	attr_accessible :caption, :asset, :cover, :markers, :marker_list

    belongs_to :member

  	has_many :comments, as: :commentable, :dependent => :destroy
  	has_many :activities, as: :targetable, :dependent => :destroy
    has_many :mentions, as: :mentioner, dependent: :destroy
  	
  	acts_as_votable
  	acts_as_ordered_taggable
  	acts_as_ordered_taggable_on :markers

    has_attached_file :asset, styles: lambda { |a| a.instance.asset_content_type =~ %r(image) ? {large: "700x700>", medium: "300x200>", list: "188", activity: "300>", small: "260x180>", thumb: "60x60#", thumb2: "30x30#", av: "200x200#"}  : {} }
    has_attached_file :cover, styles: { activity: "195x195#", media: "188x188#", thumb: "30x30#" }

  	before_create :make_it_permalink
  	before_validation :clean_up_markers
    after_save :save_mentions, unless: Proc.new { |medium| medium.caption.blank? }

    validates_attachment_presence :asset, message: 'image/audio can\'t be blank.'                    
    validates_attachment_size :asset, :less_than=>15.megabyte, message: 'image/audio must be less than or equal to 15mb.'
    validates_attachment_content_type :asset, 
                                      :content_type=>['image/jpeg', 'image/jpg', 'image/png', 
                                        'audio/mp3', 'audio/mpeg', 'audio/mpeg3', 'audio/mpg',
                                        'audio/x-mp3', 'audio/x-mpeg', 'audio/x-mpeg3', 'audio/x-mpegaudio', 'audio/x-mpg'],
                                        message: 'must be a .jpeg, .jpg, .png, or .mp3 file type.'

    validates_attachment_size :cover, :less_than_or_equal_to=>15.megabyte, message: 'must be less than or equal to 15mb.'
    validates_attachment_content_type :cover, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
                                                message: 'must be a .jpeg, .jpg, or .png file type.'

  	validates :marker_list, allow_blank: true,
                  					length: {
                                        maximum: 5,
                                        message: '(tags) must not list more than 5 tags.'
                                      },
                                      format: {
                                        with: /^[a-zA-Z0-9 ,-]+$/,
                                        message: '(tags) must not include any special characters.'
                                      }
    validate :each_marker
 
    auto_strip_attributes :caption

    searchable :auto_index => true, :auto_remove => true do
      text :marker_list, :boost => 5
      text :caption
      string :marker_list, :multiple => true, :stored => true
    end

    USERNAME_REGEX = /@\w+/i

	private

		def each_marker
	    marker_list.each do |marker|
	      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
	      errors.add(:marker, "(tag) is too long (maximum is 30 characters).") if marker.length > 30
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

    def save_mentions
      return unless mention?

      people_mentioned.each do |member|
        Mention.create!(:status_id => self.id, :mentioner_id => self.id, :mentioner_type => 'Medium', :mentionable_id => member.id, :mentionable_type => 'Member')
      end
    end

    def mention?
      self.caption.match( USERNAME_REGEX )
    end

    def people_mentioned
      members = []
      self.caption.clone.gsub!( USERNAME_REGEX ).each do |user_name|
        member = Member.find_by_user_name(user_name[1..-1])
        members << member if member
      end
      members.uniq
    end
	
end
