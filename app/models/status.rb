class Status < ActiveRecord::Base
  attr_accessible :content, :member_id, :document_attributes
  belongs_to :member 
  belongs_to :document
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :document

  validates :content, presence: true,
  			length: { minimum: 2, maximum: 280 }

  validates :member_id, presence: true

end
