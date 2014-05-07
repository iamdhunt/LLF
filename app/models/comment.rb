class Comment < ActiveRecord::Base
  belongs_to :member
  belongs_to :commentable, polymorphic: true
  attr_accessible :content

  validates :content, presence: true,
  			length: { minimum: 2, maximum: 280 }
end
