class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  					:full_name, :user_name, :pursuits, :avatar, :bio, :city, :state, :country, :pursuit_list, 
            :facebook, :twitter, :linkedin, :soundcloud, :youtube, :vimeo, :instagram, :flickr, :google, :pinterest, :blog, :website, :banner,
            :remove_banner, :remove_avatar, :admin, :verified
  
  attr_accessor :login, :remove_banner, :remove_avatar

  acts_as_follower
  acts_as_followable
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :pursuits
  acts_as_voter
  acts_as_messageable

  has_many :medium, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :statuses, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :uploads, :dependent => :destroy
  has_many :updates, :dependent => :destroy
  has_many :assets, :dependent => :destroy
  has_many :mentions, as: :mentionable, dependent: :destroy

  has_attached_file :avatar, styles: { large: "700x700>", medium: "300x200>", small: "260x180>", activity: "300>", follow: "175x175#", thumb: "30x30#", thumb2: "35x35#", listing: "24x24#", av: "200x200#", comment: "22x22#", comment2: "40x40#"},
                    :default_url => '/assets/Default Av.png',
                    :convert_options => { all: "-set -colorspace sRGB" }

  has_attached_file :banner, styles: { large: "1400x200<", preview: "600x200>" },
                    :convert_options => { all: "-set -colorspace sRGB" }

  before_validation :clean_up_pursuits
  before_save :to_lower, :perform_banner_removal, :perform_avatar_removal
  before_create :to_lower
  after_create :send_welcome

  validates :full_name, presence: { message: 'can\'t be blank.'},
                        length: {
                          maximum: 50, 
                          message: 'must not be longer than 50 characters.'
                        }

  validates :user_name, presence: { message: 'can\'t be blank.'},
                        uniqueness: { :case_sensitive => false, message: 'is already taken.'},
                        format: {
                          with: /^[a-zA-Z0-9_]+$/,
                          message: 'must not include spaces or special characters.'
                        },
                        length: {
                          maximum: 16,
                          message: 'must not be longer than 16 characters.'
                        },
                        exclusion: {
                          in: %w(faqs community media market events projects members terms privacy rules blog login logout join admin dashboard grla rbreed frls search discover edit settings conversations notifications),
                          message: 'is already taken.'
                        }                 

  validates_attachment_size :avatar, :less_than_or_equal_to=>10.megabyte, message: 'must be less than or equal to 10mb.'
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
                                              message: 'must be a .jpeg, .jpg, or .png file type.'

  validates_attachment_size :banner, :less_than_or_equal_to=>10.megabyte, message: 'must be less than or equal to 10mb.'
  validates_attachment_content_type :banner, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
                                              message: 'must be a .jpeg, .jpg, or .png file type.'

  validates :pursuit_list,  allow_blank: true,
                            length: {
                              maximum: 5,
                              message: 'must not list more than 5 pursuits.'
                            },
                            format: {
                              with: /^[a-zA-Z ,'-]+$/,
                              message: 'must not include any special characters or numbers.'
                            }
  validate :each_pursuit

  validates :facebook, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :twitter, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :linkedin, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :soundcloud, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :youtube, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :vimeo, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :instagram, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :flickr, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :google, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :pinterest, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :blog, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }
                       
  validates :website, allow_blank: true,
                       length: {
                        minimum: 4,
                        message: 'must be longer than 4 characters.'
                       }

  validates :bio, allow_blank: true,
                  length: {
                    maximum: 140,
                    message: 'must not be longer than 140 characters.'
                  }

 validates :city, allow_blank: true,
                  format: {
                    with: /^[a-zA-Z- ]+$/,
                    message: 'must not include any special characters or numbers.'
                  },
                  length: {
                    maximum: 25,
                    message: 'must not be longer than 25 characters.'
                  } 

  validates :state, allow_blank: true,
                    format: {
                      with: /^[a-zA-Z- ]+$/,
                      message: 'must not include any special characters or numbers.'
                    },
                    length: {
                      maximum: 25,
                      message: 'must not be longer than 25 characters.'
                    } 

  validates :country, allow_blank: true,
                      format: {
                        with: /^[a-zA-Z- ]+$/,
                        message: 'must not include any special characters or numbers.'
                      },
                      length: {
                        maximum: 100,
                        message: 'must not be longer than 100 characters.'
                      }

  auto_strip_attributes :email, :password, :password_confirmation, :user_name, :bio, :facebook, :twitter, :linkedin, :soundcloud, :youtube, :vimeo, :instagram, :flickr, :google, :pinterest, :blog, :website
  auto_strip_attributes :city, :squish => true
  auto_strip_attributes :state, :squish => true
  auto_strip_attributes :country, :squish => true
  auto_strip_attributes :full_name, :squish => true

  def to_param
    user_name
  end 

  def name
    return user_name
  end 

  def mailboxer_email(object)
    return email
  end

  def create_activity(item, action)
    activity = activities.new
    activity.targetable = item
    activity.action = action 
    activity.save 
    activity
  end

  searchable :auto_index => true, :auto_remove => true do
    text :user_name, :full_name, :pursuit_list, :boost => 5
    text :city, :state, :country
    string :pursuit_list, :multiple => true, :stored => true
    string :city
  end

  def is_admin?
    self.admin == true
  end

private

  def to_lower
    self.user_name = self.user_name.downcase
    self.email = self.email.downcase
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

  def each_pursuit
    pursuit_list.each do |pursuit|
      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
      errors.add(:pursuit, "is too long (maximum is 30 characters).") if pursuit.length > 30
    end
  end

  def clean_up_pursuits
    # Make lowercase 
    self.pursuit_list.map!(&:downcase) 
  end

  def send_welcome
    MemberMailer.signup_confirmation(self).deliver
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["user_name = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

end
