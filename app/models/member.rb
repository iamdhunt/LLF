class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  					:first_name, :last_name, :user_name
  # attr_accessible :title, :body

  validates :first_name, presence: true,
                          format: {
                          with: /^[a-zA-Z]+$/,
                          message: 'Must be formatted correctly.'
                        }

  validates :last_name, presence: true,
                        format: {
                          with: /^[a-zA-Z]+$/,
                          message: 'Must be formatted correctly.'
                        }

  validates :user_name, presence: true,
                        uniqueness: true,
                        format: {
                          with: /^[a-zA-Z0-9_-]+$/,
                          message: 'Must be formatted correctly.'
                        }

  has_many :statuses

  def full_name
  		first_name + " " + last_name
  end
end
