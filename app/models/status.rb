class Status < ActiveRecord::Base
  attr_accessible :content, :member_id, :document_attributes, :permalink
  belongs_to :member 
  belongs_to :document
  has_many :comments, as: :commentable, dependent: :destroy

  before_save :make_it_permalink

  accepts_nested_attributes_for :document

  validates :content, presence: true,
  			length: { 
  				minimum: 2,
  				message: 'must be longer than 2 characters.', 
  				maximum: 280,
  				message: 'must not be more than 280 characters.' 
  			}

  validates :member_id, presence: true

  auto_html_for :content do
      html_escape
      youtube(:width => 305, :height => 250, :autoplay => false)
      vimeo(:width => 305, :height => 250, :autoplay => false)
      simple_format
  end

  def to_param
    permalink
  end

  def path
    status_path(status)
  end 

  private

  def make_it_permalink
    # this can create permalink with random 8 digit alphanumeric
    self.permalink = SecureRandom.hex(12)
  end

end
