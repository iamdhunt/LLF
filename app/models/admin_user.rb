class AdminUser < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, 
	:recoverable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessor :login
	attr_accessible :user_name, :email, :password, :password_confirmation, :remember_me, :login

	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
	      where(conditions).where(["lower(email) = lower(:value) OR user_name = :value", { :value => login }]).first
	    else
	      where(conditions).first
	    end
	end
end
