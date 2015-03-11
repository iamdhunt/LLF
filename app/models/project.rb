class Project < ActiveRecord::Base
	belongs_to :member

  before_create :make_it_permalink

  	attr_accessible :about, :blurb, :category, :markers, :video, :website, :name, :avatar, :banner, :marker_list, :city

    auto_strip_attributes :about, :website
    auto_strip_attributes :name, :squish => true
    auto_strip_attributes :city, :squish => true
    auto_strip_attributes :blurb, :squish => true

  	validates :about, presence: true
  	validates :blurb, presence: true,
  						length: {
                          maximum: 140, 
                          message: 'must not be more than 140 characters.'
                        }
  	validates :category, presence: true,
              inclusion: {
                in: %w(Arts Entrepreneurial Music Sports Other)
              }
  	validates :marker_list, presence: true,
  						length: {
                              maximum: 3,
                              message: '(tags) must not list more than 3 tags.'
                            },
                            format: {
                              with: /^[a-zA-Z0-9 ,-]+$/,
                              message: '(tags) must not include any special characters or numbers.'
                            }
    validate :each_marker
  	validates :name, presence: true,
  						length: {
                          maximum: 100, 
                          message: 'must not be more than 100 characters.',
                          minimum: 2,
                          message: 'must be longer than 2 characters.'
                        }
    validates :city, presence: true, 
                        format: {
                          with: /^[a-zA-Z ]+$/,
                          message: 'must not include any special characters or numbers.'
                        },length: {
                          maximum: 100, 
                          message: 'must not be more than 100 characters.',
                        }

  	acts_as_votable
    acts_as_followable
    acts_as_ordered_taggable
  	acts_as_ordered_taggable_on :markers
    acts_as_messageable
    has_many :comments, as: :commentable, :dependent => :destroy
    has_many :uploads, as: :uploadable, :dependent => :destroy
    has_many :updates, as: :updateable, :dependent => :destroy
    has_many :activities, as: :targetable, :dependent => :destroy

  	before_validation :clean_up_markers

  	has_attached_file :avatar, styles: {activity: "300>", thumb: "30x30#", av: "165x165#", list: "230x230#"},
  								:default_url => '/assets/Projects Default.png'
  	has_attached_file :banner, styles: { large: "1400x200<", preview: "600x200>" },
  								:default_url => '/assets/Projects Default Banner.png'

 	  validates_attachment_size :avatar, :less_than_or_equal_to=>10.megabyte
  	validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	validates_attachment_size :banner, :less_than_or_equal_to=>10.megabyte
  	validates_attachment_content_type :banner, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	auto_html_for :video do
	    html_escape
	    image
	    youtube(:width => 660, :height => 400, :autoplay => false)
	    vimeo(:width => 660, :height => 400, :autoplay => false)
	    simple_format
	  end

    searchable :auto_index => true, :auto_remove => true do
      text :name, :boost => 5
      text :marker_list, :boost => 3
      text :city, :boost => 2
      text :category
      string :marker_list, :multiple => true, :stored => true
      string :city
    end

    def to_param
      "#{id}-#{name.parameterize}"
    end  

  	private

	  def each_marker
	    marker_list.each do |marker|
	      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
	      errors.add(:marker, "(tag) too long (Maximum is 30 characters)") if marker.length > 30
	    end
	  end

	  def clean_up_markers
	    # Make lowercase 
	    self.marker_list.map!(&:downcase) 
	  end

    def make_it_permalink
      # this can create permalink with random 8 digit alphanumeric
      self.permalink = SecureRandom.hex(12)
    end

end