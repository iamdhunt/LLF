class Project < ActiveRecord::Base
	belongs_to :member
  	attr_accessible :about, :blurb, :category, :tags, :video, :website, :title, :avatar, :banner, :tag_list, :test

  	validates :about, presence: true
  	validates :blurb, presence: true,
  						length: {
                          maximum: 280, 
                          message: 'must not be more than 280 characters.'
                        }
  	validates :category, presence: true
  	validates :tag_list, presence: true,
  						length: {
                              maximum: 3,
                              message: 'must not list more than 3 tags.'
                            },
                            format: {
                              with: /^[a-zA-Z ,-]+$/,
                              message: 'must be formatted correctly.'
                            }
    validate :each_tag
  	validates :title, presence: true,
  						length: {
                          maximum: 60, 
                          message: 'must not be more than 60 characters.',
                          minimum: 2,
                          message: 'must be longer than 2 characters.'
                        }

  	acts_as_votable
    acts_as_followable
    acts_as_ordered_taggable
  	acts_as_ordered_taggable_on :tags
    has_many :comments, as: :commentable
    has_many :uploads, as: :uploadable
    has_many :updates, as: :updateable

  	before_validation :clean_up_tags
  	before_save :titleize
  	before_create :titleize

  	has_attached_file :avatar, styles: {activity: "300>", thumb: "30x30#", av: "165x165#", list: "230x230#"},
  								:default_url => '/assets/Projects Default.png'
  	has_attached_file :banner, styles: { large: "1400x200<", preview: "600x200>" },
  								:default_url => '/assets/Projects Default Banner.png'

 	  validates_attachment_size :avatar, :less_than_or_equal_to=>5.megabyte
  	validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	validates_attachment_size :banner, :less_than_or_equal_to=>5.megabyte
  	validates_attachment_content_type :banner, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	auto_html_for :video do
	    html_escape
	    image
	    youtube(:width => 660, :height => 400, :autoplay => false)
	    vimeo(:width => 660, :height => 400, :autoplay => false)
	    link :target => "_blank", :rel => "nofollow"
	    simple_format
	  end

    searchable do
      text :tag_list
    end

    handle_asynchronously :solr_index
    handle_asynchronously :remove_from_index

  	private

    

	  def titleize
	    self.about = self.about.titleize
	    self.blurb = self.blurb.titleize
	  end 

	  def each_tag
	    tag_list.each do |tag|
	      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
	      errors.add(:tag, "Too long (Maximum is 15 characters)") if tag.length > 15
	    end
	  end

	  def clean_up_tags
	    # Make lowercase 
	    self.tag_list.map!(&:downcase) 
	  end

end
