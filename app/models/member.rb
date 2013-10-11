class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :remember_me,
  					:first_name, :last_name, :user_name, :pursuits, :avatar, :bio, :city, :state, :country, :pursuit_list

  validates :first_name, presence: true,
                          format: {
                          with: /^[a-zA-Z ]+$/,
                          message: 'must be formatted correctly.'
                        },
                        length: {
                          maximum: 1, :tokenizer => lambda {|str| str.scan(/\w+/) },
                          message: 'must not be more than one name.',
                          maximum: 15, 
                          message: 'must not be more than 15 characters.'
                        }

  validates :last_name, presence: true,
                        format: {
                          with: /^[a-zA-Z -]+$/,
                          message: 'must be formatted correctly.'
                        },
                        length: {
                          maximum: 2, :tokenizer => lambda {|str| str.scan(/\w+/) },
                          message: 'must not be more than 2 names.',
                          maximum: 20, 
                          message: 'must not be more than 20 characters.'
                        }

  validates :user_name, presence: true,
                        uniqueness: true,
                        format: {
                          with: /^[a-zA-Z0-9_-]+$/,
                          message: 'must be formatted correctly.'
                        },
                        length: {
                          maximum: 16,
                          message: 'must not be longer than 16 characters'
                        }                    

  validates :email, confirmation: true

  validates :pursuit_list,  allow_blank: true,
                            length: {
                              maximum: 5,
                              message: 'must not list more than 5 pursuits.'
                            },
                            format: {
                              with: /^[a-zA-Z, ]+$/,
                              message: 'must be formatted correctly.'
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
                    message: 'must be formatted correctly.'
                  },
                  length: {
                    maximum: 20,
                    message: 'must not be longer than 20 characters.'
                  } 

  validates :state, allow_blank: true,
                    format: {
                      with: /^[a-zA-Z- ]+$/,
                      message: 'must be formatted correctly.'
                    },
                    length: {
                      maximum: 12,
                      message: 'must not be longer than 12 characters.'
                    } 

  validates :country, allow_blank: true,
                      format: {
                        with: /^[a-zA-Z- ]+$/,
                        message: 'must be formatted correctly.'
                      },
                      length: {
                        maximum: 20,
                        message: 'must not be longer than 20 characters.'
                      }

  before_save :titleize, :to_lower
  before_create :titleize, :to_lower

  has_many :medium
  has_many :statuses
  has_many :activities
  acts_as_follower
  acts_as_followable
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :pursuits

  has_attached_file :avatar, styles: { large: "700x700>", medium: "300x200>", small: "260x180>", follow: "175x175#", thumb: "60x60#", av: "200x200#"}

  validates_attachment_size :avatar, :less_than=>10.megabyte
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  def full_name
  		first_name + " " + last_name
  end

  def to_param
    user_name
  end 

  def create_activity(item, action)
    activity = activities.new
    activity.targetable = item
    activity.action = action 
    activity.save 
    activity
  end 

  private

  def titleize
    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
  end 

  def to_lower
    self.user_name = self.user_name.downcase
  end 

  def each_pursuit
    pursuit_list.each do |pursuit|
      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
      errors.add(:pursuit, "Too long (Maximum is 25 characters)") if pursuit.length > 25
    end
  end 

end
