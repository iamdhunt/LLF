class Status < ActiveRecord::Base
  attr_accessible :content, :member_id, :document_attributes, :permalink
  belongs_to :member 
  belongs_to :document
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :activities, as: :targetable, :dependent => :destroy
  has_many :mentions, dependent: :destroy

  before_create :make_it_permalink
  after_create :create_mention

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

  def path
    status_path(status)
  end 

  

  private

  def make_it_permalink
    # this can create permalink with random 8 digit alphanumeric
    self.permalink = SecureRandom.hex(12)
  end

  def create_mention(mentionable, mention)
    matcher = /@(\w+)/i
    finder = :find_by_user_name

    text = self.send(content)

    text.scan(matcher)
    if text =~ matcher
      alert "@ mentions present"
    end
  end

end
