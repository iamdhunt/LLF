class Project < ActiveRecord::Base

  attr_accessible :about, :blurb, :category, :markers, :video, :website, :name, :avatar, :banner, :marker_list, :city,
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
                  :default_url => '/assets/Projects-Default.png',
                  :convert_options => { all: "-set -colorspace sRGB" }
  has_attached_file :banner, styles: { large: "1400x200<", preview: "600x200>" },
                  :default_url => '/assets/Projects Banner Image.jpg',
                  :convert_options => { all: "-set -colorspace sRGB" }

  before_create :make_it_permalink
  before_validation :clean_up_markers

  after_save :save_mentions
  before_save :perform_banner_removal, :perform_avatar_removal

  validates :name, presence: { message: 'can\'t be blank.'},
            length: {
                        maximum: 100, 
                        message: 'must not be more than 100 characters.'
                      }

  validates_attachment_size :avatar, :less_than_or_equal_to=>10.megabyte, message: 'must be less than or equal to 10mb.'
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
                                              message: 'must be a .jpeg, .jpg, or .png file type.'

  validates_attachment_size :banner, :less_than_or_equal_to=>10.megabyte, message: 'must be less than or equal to 10mb.'
  validates_attachment_content_type :banner, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
                                              message: 'must be a .jpeg, .jpg, or .png file type.'

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

  validates :city, presence: { message: 'can\'t be blank.'}, 
                      format: {
                        with: /^[a-zA-Z ]+$/,
                        message: 'must not include any special characters or numbers.'
                      },length: {
                        maximum: 100, 
                        message: 'must not be more than 100 characters.',
                      }

	validates :blurb, presence: { message: 'can\'t be blank.'},
						length: {
                        maximum: 140, 
                        message: 'must not be more than 140 characters.'
                      }

  validates :about, presence: { message: 'can\'t be blank.'}

  validates :video, allow_blank: true,
                      format: { 
                        :with => /^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be|vimeo\.com|soundcloud\.com)\/.+$/,
                        message: 'or audio must be from YouTube, Vimeo, or Soundcloud.'
                      }

  auto_strip_attributes :about, :website
  auto_strip_attributes :name, :squish => true
  auto_strip_attributes :city, :squish => true
  auto_strip_attributes :blurb, :squish => true

  searchable :auto_index => true, :auto_remove => true do
    text :name, :boost => 5
    text :marker_list, :boost => 3
    text :city, :boost => 2
    text :category
    string :marker_list, :multiple => true, :stored => true
    string :city
  end

  def to_param
    "#{id}-#{name.parameterize}"
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
        Mention.create!(:project_id => self.id, :mentioner_id => self.id, :mentioner_type => 'Project', :mentionable_id => member.id, :mentionable_type => 'Member')
      end
    end

    def mention?
      self.about.match( USERNAME_REGEX )
    end

    def people_mentioned
      members = []
      self.about.clone.gsub!( USERNAME_REGEX ).each do |user_name|
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