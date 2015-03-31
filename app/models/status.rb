class Status < ActiveRecord::Base

  attr_accessor :mention
  attr_accessible :content, :member_id, :document_attributes, :permalink

  belongs_to :member 
  belongs_to :document

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :activities, as: :targetable, :dependent => :destroy
  has_many :mentions, dependent: :destroy

  auto_strip_attributes :content

  before_create :make_it_permalink
  after_save :save_mentions

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

  USERNAME_REGEX = /@\w+/i


  private

  def make_it_permalink
    # this can create permalink with random 12 digit alphanumeric
    self.permalink = SecureRandom.hex(12)
  end

  def save_mentions
    return unless mention?

    people_mentioned.each do |member|
      Mention.create!(:status_id => self.id, :member_id => member.id, :mentionable_type => 'Status', :mentionable_id => member.id)
    end
  end

  def mention?
    self.content.match( USERNAME_REGEX )
  end

  def people_mentioned
    members = []
    self.content.clone.gsub!( USERNAME_REGEX ).each do |user_name|
      member = Member.find_by_user_name(user_name[1..-1])
      members << member if member
    end
    members.uniq
  end
  
end
