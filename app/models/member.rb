class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :remember_me,
  					:full_name, :user_name, :pursuits, :avatar, :bio, :city, :state, :country, :pursuit_list, 
            :facebook, :twitter, :linkedin, :soundcloud, :youtube, :vimeo, :instagram, :flickr, :google, :pinterest, :blog, :website, :banner

  validates :full_name, presence: true,
                        length: {
                          maximum: 50, 
                          message: 'must not be more than 50 characters.'
                        }

  validates :user_name, presence: true,
                        uniqueness: true,
                        format: {
                          with: /^[a-zA-Z0-9_-]+$/,
                          message: 'can not include spaces or special characters.'
                        },
                        length: {
                          maximum: 16,
                          message: 'must not be longer than 16 characters'
                        },
                        exclusion: {
                          in: %w(faqs community market events projects members terms privacy blog login logout join llf_adm grla rbreed frls search discover),
                          message: 'is already taken.'
                        }                 

  validates :email, confirmation: true

  validates :pursuit_list,  allow_blank: true,
                            length: {
                              maximum: 5,
                              message: 'must not list more than 5 pursuits.'
                            },
                            format: {
                              with: /^[a-zA-Z ,-]+$/,
                              message: 'must be formatted correctly. Only letters.'
                            }
  validate :each_pursuit

  validates :bio, allow_blank: true,
                  length: {
                    maximum: 140,
                    message: 'must not be longer than 140 characters'
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
                        maximum: 25,
                        message: 'must not be longer than 25 characters.'
                      }

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

  before_validation :clean_up_pursuits
  before_save :to_lower
  before_create :to_lower
  after_create :send_welcome

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
  acts_as_follower
  acts_as_followable
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :pursuits
  acts_as_voter
  acts_as_messageable

  has_attached_file :avatar, styles: { large: "700x700>", medium: "300x200>", small: "260x180>", activity: "300>", follow: "175x175#", thumb: "30x30#", thumb2: "35x35#", listing: "24x24#", av: "200x200#", comment: "22x22#", comment2: "40x40#"},
                    :default_url => '/assets/Default Av.png'

  has_attached_file :banner, styles: { large: "1400x200<", preview: "600x200>" }

  validates_attachment_size :avatar, :less_than_or_equal_to=>5.megabyte
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  validates_attachment_size :banner, :less_than_or_equal_to=>5.megabyte
  validates_attachment_content_type :banner, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

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

  private

  def to_lower
    self.user_name = self.user_name.downcase
    self.email = self.email.downcase
  end 

  def each_pursuit
    pursuit_list.each do |pursuit|
      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
      errors.add(:pursuit, "Too long (Maximum is 25 characters)") if pursuit.length > 25
    end
  end

  def clean_up_pursuits
    # Make lowercase 
    self.pursuit_list.map!(&:downcase) 
  end

  def send_welcome
    MemberMailer.signup_confirmation(self).deliver
  end

end
