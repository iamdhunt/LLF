class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :remember_me,
  					:first_name, :last_name, :user_name, :pursuits, :avatar, :bio, :city, :state, :country

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
                          with: /^[a-zA-Z- ]+$/,
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

  validates :pursuits,  allow_blank: true,
                        format: {
                          with: /^[a-zA-Z ]+$/,
                          message: 'must be formatted correctly.'
                        },
                        length: {
                          maximum: 2, :tokenizer => lambda {|str| str.scan(/\w+/) },
                          message: 'must not be more than two words.'
                        }

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

  has_many :medium
  has_many :statuses
  acts_as_follower
  acts_as_followable

  has_attached_file :avatar, styles: { large: "700x700>", medium: "300x200>", small: "260x180>", thumb: "60x60#", av: "200x200#"}

  validates_attachment_size :avatar, :less_than=>10.megabyte
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  def full_name
  		first_name + " " + last_name
  end

  def to_param
    user_name
  end 

end
