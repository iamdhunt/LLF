class Event < ActiveRecord::Base

  attr_accessible :blurb, :details, :category, :markers, :video, :website, :name, :avatar, :banner, :marker_list, :location, :address,
                  :city, :zipcode, :state, :country, :start_date, :end_date, :start_time, :end_time,
                  :remove_banner, :remove_avatar

  attr_accessor :mention, :remove_banner, :remove_avatar

	belongs_to :member

  acts_as_votable
  acts_as_followable
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :markers
  acts_as_messageable

  has_many :comments, as: :commentable, :dependent => :destroy
  has_many :uploads, as: :uploadable, :dependent => :destroy
  has_many :updates, as: :updateable, :dependent => :destroy
  has_many :activities, as: :targetable, :dependent => :destroy
  has_many :mentions, as: :mentioner, dependent: :destroy

  has_attached_file :avatar, styles: {activity: "300>", thumb: "30x30#", av: "165x165#", list: "230x230#"},
                  :default_url => '/assets/Events-Default.png',
                  :convert_options => { activity: "-colorspace sRGB", thumb: "-colorspace sRGB", av: "-colorspace sRGB", list: "-colorspace sRGB" }
  has_attached_file :banner, styles: { large: "1400x200<", preview: "600x200>" },
                  :default_url => '/assets/Events Banner Image.jpg',
                  :convert_options => { all: "-set -colorspace sRGB" }

  before_create :make_it_permalink
  before_validation :clean_up_markers
  before_save :perform_banner_removal, :perform_avatar_removal

  after_save :save_mentions
  
    validates :name, presence: { message: 'can\'t be blank.'},
              length: {
                          maximum: 100, 
                          message: 'must not be more than 100 characters.'
                        }

    validates :category, presence: { message: 'can\'t be blank.'},
              inclusion: {
                in: ['Arts', 'Entrepreneurial', 'Music', 'Sports & Rec', 'Other'],
                message: 'is not included in the list.'
              } 

    validates :marker_list, presence: { message: '(tags) can\'t be blank.'},
              length: {
                              maximum: 3,
                              message: '(tags) must not list more than 3 tags.'
                            },
                            format: {
                              with: /^[a-zA-Z0-9 ,'-]+$/,
                              message: '(tags) must not include any special characters.'
                            }
    validate :each_marker     

    validates_attachment_size :avatar, :less_than_or_equal_to=>10.megabyte, message: 'must be less than or equal to 10mb.'
    validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
                                                message: 'must be a .jpeg, .jpg, or .png file type.'

    validates_attachment_size :banner, :less_than_or_equal_to=>10.megabyte, message: 'must be less than or equal to 10mb.'
    validates_attachment_content_type :banner, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
                                                message: 'must be a .jpeg, .jpg, or .png file type.'

    validates :start_date, presence: { message: 'can\'t be blank.'}
    validates :end_date, presence: { message: 'can\'t be blank.'}
    validates :start_time, presence: { message: 'can\'t be blank.'}
    validates :end_time, presence: { message: 'can\'t be blank.'} 

    validates :location, allow_blank: true,
              length: {
                          maximum: 100, 
                          message: 'name must not be more than 100 characters.',
                          minimum: 2,
                          message: 'name must be longer than 2 characters.'
                        }

    validates :address, allow_blank: true,
                        format: {
                          with: /^[a-zA-Z0-9 -.]+$/,
                          message: 'must not include any special characters.'
                        },length: {
                          maximum: 100, 
                          message: 'must not be more than 100 characters.',
                        }

    validates :city, allow_blank: true,
                        format: {
                          with: /^[a-zA-Z -']+$/,
                          message: 'must not include any special characters or numbers.'
                        },length: {
                          maximum: 100, 
                          message: 'must not be more than 100 characters.',
                        }

    validates :zipcode, allow_blank: true,
                        format: {
                          with: /^[0-9 -]+$/,
                          message: 'must not include any special characters or letters.'
                        },length: {
                          maximum: 9, 
                          message: 'must not be more than 9 characters.',
                        }

    validates :state, allow_blank: true, 
                        format: {
                          with: /^[a-zA-Z ]+$/,
                          message: 'must not include any special characters or numbers.'
                        },length: {
                          maximum: 100, 
                          message: 'must not be more than 100 characters.',
                        }

    validates :country, allow_blank: true,
                        format: {
                          with: /^[a-zA-Z ]+$/,
                          message: 'must not include any special characters or numbers.'
                        },length: {
                          maximum: 100, 
                          message: 'must not be more than 100 characters.',
                        }           

	  validates :details, presence: { message: 'can\'t be blank.'} 

  	validates :blurb, presence: { message: 'can\'t be blank.'},
  						length: {
                          maximum: 140, 
                          message: 'must not be more than 140 characters.'
                        }

    validates :video, allow_blank: true,
                      format: { 
                        :with => /^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be|vimeo\.com|soundcloud\.com)\/.+$/,
                        message: 'or audio must be from YouTube, Vimeo, or Soundcloud.'
                      }

    auto_strip_attributes :website, :zipcode, :details
    auto_strip_attributes :name, :squish => true
    auto_strip_attributes :location, :squish => true
    auto_strip_attributes :address, :squish => true
    auto_strip_attributes :city, :squish => true
    auto_strip_attributes :state, :squish => true
    auto_strip_attributes :country, :squish => true
    auto_strip_attributes :blurb, :squish => true

  searchable :auto_index => true, :auto_remove => true do
    text :name, :boost => 5
    text :marker_list, :boost => 2
    text :city, :location
    text :category
    text :blurb, :boost => 2
    string :marker_list, :multiple => true, :stored => true
    string :event_month
    string :location
    date :start_date
    date :end_date
  end

  USERNAME_REGEX = /@\w+/i

  def event_month
    start_date.strftime("%B")
  end

  def follow_list
      followers.map{|u| u.user_name }
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end   

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
        Mention.create!(:event_id => self.id, :mentioner_id => self.id, :mentioner_type => 'Event', :mentionable_id => member.id, :mentionable_type => 'Member')
      end
    end

    def mention?
      self.details.match( USERNAME_REGEX )
    end

    def people_mentioned
      members = []
      self.details.clone.gsub!( USERNAME_REGEX ).each do |user_name|
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

    def perform_avatar_removal
      if remove_avatar == '1' && !avatar.dirty?
        self.avatar = nil
      end
    end

end
