class Listing < ActiveRecord::Base
  	
  	attr_accessible :category, :description, :price, :title, :link, :feature, :markers, :marker_list, :assets_attributes, :cover, :banner,
                      :remove_banner, :remove_cover, :remove_feature, :embed, :button

    attr_accessor :mention, :remove_banner, :remove_cover, :remove_feature

    belongs_to :member

    acts_as_votable
    acts_as_ordered_taggable
    acts_as_ordered_taggable_on :markers
    has_many :comments, as: :commentable, :dependent => :destroy
    has_many :assets, :dependent => :destroy
    has_many :activities, as: :targetable, :dependent => :destroy
    has_many :mentions, as: :mentioner, dependent: :destroy

    has_attached_file :feature, styles: lambda { |a| a.instance.feature_content_type =~ %r(image) ? { large: "700x700>", feature: "380x380#", activity: "300>", thumb: "30x30#", index: "230x230#", list: "230x230#", form: "188x188#", additional: "100x100#" } : {} },
                      :default_url => '/assets/Listings-List-Default.png',
                      :convert_options => { all: lambda{ |instance| (instance.feature_content_type =~ %r(image)) ?  "-set -colorspace sRGB" : {} } }
    has_attached_file :cover, styles: { cover: "230x230#", form: "188x188#", small: "100x100#" },
                      :convert_options => { all: "-set -colorspace sRGB" }
    has_attached_file :banner, styles: { large: "1400x200<", preview: "600x200>" },
                      :default_url => '/assets/Market Banner Img.jpg',
                      :convert_options => { all: "-set -colorspace sRGB" }

    accepts_nested_attributes_for :assets, :allow_destroy => true

    before_create :make_it_permalink
    before_save :perform_banner_removal, :perform_cover_removal
    before_validation :perform_feature_removal, :strip_commas_from_price, :clean_up_markers

    after_save :save_mentions, unless: Proc.new { |listing| listing.description.blank? }

  	validates :title, presence: { message: '(name) can\'t be blank.'}

    validates :price, presence: { message: 'can\'t be blank.'},
              length: {
                              maximum: 9,
                              message: 'must be longer than 9 characters.'
                            },
                            format: {
                              with: /^[0-9 ,.]+$/,
                              message: 'must not include any special characters or letters.'
                            }
    validates_numericality_of :price, :less_than_or_equal_to => 1500, message: 'can\'t be greater than 1,500.'

  	validates :link, presence: { message: 'can\'t be blank.'}

    validates_attachment_presence :feature, :unless => :embed?, message: 'must have an attached image/audio or a specified link.'
    validates_attachment_size :feature, :less_than_or_equal_to=>15.megabyte, message: 'image/audio must be less than or equal to 15mb.'
    validates_attachment_content_type :feature, 
                                      :content_type=>['image/jpeg', 'image/jpg', 'image/png', 
                                            'audio/mp3', 'audio/mpeg', 'audio/mpeg3', 'audio/mpg',
                                            'audio/x-mp3', 'audio/x-mpeg', 'audio/x-mpeg3', 'audio/x-mpegaudio', 'audio/x-mpg'],
                                      message: 'must be a .jpeg, .jpg, .png, or .mp3 file type.'

    validates_attachment_size :cover, :less_than_or_equal_to=>15.megabyte, message: 'must be less than or equal to 15mb.'
    validates_attachment_content_type :cover, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
                                              message: 'must be a .jpeg, .jpg, or .png file type.'

    validates_attachment_size :banner, :less_than_or_equal_to=>10.megabyte, message: 'must be less than or equal to 10mb.'
    validates_attachment_content_type :banner, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
                                                message: 'must be a .jpeg, .jpg, or .png file type.'

  	validates :category, presence: { message: 'can\'t be blank.'},
  						inclusion: {
  							in: %w(Men's Women's Art Music Design Services),
                message: 'is not included in the list.'
  						}

  	validates :marker_list, presence: { message: '(tags) can\'t be blank.'},
  						length: {
                              maximum: 5,
                              message: '(tags) must not list more than 5 tags.'
                            },
                            format: {
                              with: /^[a-zA-Z0-9 ,'-]+$/,
                              message: '(tags) must not include any special characters.'
                            }
    validate :each_marker 

    validates :embed, allow_blank: true,
                      format: { 
                        :with => /^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be|vimeo\.com|soundcloud\.com)\/.+$/,
                        message: 'link must be from YouTube, Vimeo, or Soundcloud.'
                      }

    validate :embed_or_attachment

    validates :button, presence: { message: 'can\'t be blank.'},
              inclusion: {
                in: ['Buy Now', 'Preorder', 'Download', 'Contact Me', 'Learn More'],
                message: 'is not included in the list.'
              } 

    auto_strip_attributes :description, :link
    auto_strip_attributes :title, :squish => true

    searchable :auto_index => true, :auto_remove => true do
      text :title, :boost => 5
      text :marker_list, :boost => 2
      string :marker_list, :multiple => true, :stored => true
      double :price
    end

    def to_param
      "#{id}-#{title.parameterize}"
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

  	  def strip_commas_from_price
  		  self.price = self.price.to_s.gsub(/,/, '').to_f
  	  end

      def make_it_permalink
        # this can create permalink with random 8 digit alphanumeric
        self.permalink = SecureRandom.hex(12)
      end

      def save_mentions
        return unless mention?

        people_mentioned.each do |member|
          Mention.create!(:listing_id => self.id, :mentioner_id => self.id, :mentioner_type => 'Listing', :mentionable_id => member.id, :mentionable_type => 'Member')
        end
      end

      def mention?
        self.description.match( USERNAME_REGEX )
      end

      def people_mentioned
        members = []
        self.description.clone.gsub!( USERNAME_REGEX ).each do |user_name|
          member = Member.find_by_user_name(user_name[1..-1])
          members << member if member
        end
        members.uniq
      end 

      def perform_banner_removal
        if remove_banner == '1' && !banner.dirty?
          self.banner = nil
        end
      end

      def perform_cover_removal
        if remove_cover == '1' && !cover.dirty?
          self.cover = nil
        end
      end 

      def perform_feature_removal
        if remove_feature == '1' && !feature.dirty?
          self.feature = nil
        end
      end 

      def embed_or_attachment
      unless feature.blank? ^ embed.blank?
        errors.add(:base, "Attach an image/audio file or specify a link, but not both.")
      end
    end

end
