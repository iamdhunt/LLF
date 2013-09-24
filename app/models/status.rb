class Status < ActiveRecord::Base
  attr_accessible :content, :member_id
  belongs_to :member 

  validates :content, presence: true,
  			length: { minimum: 2, maximum: 280 }

  validates :member_id, presence: true

end
