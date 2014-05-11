class Update < ActiveRecord::Base
  	belongs_to :member
	belongs_to :updateable, polymorphic: true
	attr_accessible :title, :content

	validates :title, presence: true,
  			length: { minimum: 2, maximum: 60 }

  	validates :content, presence: true,
  			length: { minimum: 2 }
end
