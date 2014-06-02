class Event < ActiveRecord::Base
	belongs_to :member

	attr_accessible :blurb, :details, :category, :markers, :video, :website, :name, :avatar, :banner, :marker_list, :location, :address,
                  :city, :zipcode, :state, :country, :start_date, :end_date, :start_time, :end_time

	  validates :details, presence: true
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
                              message: 'must not list more than 3 tags.'
                            },
                            format: {
                              with: /^[a-zA-Z ,-]+$/,
                              message: 'must be formatted correctly.'
                            }
    validate :each_marker
  	validates :name, presence: true,
  						length: {
                          maximum: 100, 
                          message: 'must not be more than 100 characters.',
                          minimum: 2,
                          message: 'must be longer than 2 characters.'
                        }
    validates :location, presence: true,
              length: {
                          maximum: 100, 
                          message: 'must not be more than 100 characters.',
                          minimum: 2,
                          message: 'must be longer than 2 characters.'
                        }
    validates :address, presence: true,
                        format: {
                          with: /^[a-zA-Z0-9 -.]+$/,
                          message: 'must be formatted correctly.'
                        },length: {
                          maximum: 50, 
                          message: 'must not be more than 50 characters.',
                        }
    validates :city, presence: true,
                        format: {
                          with: /^[a-zA-Z -]+$/,
                          message: 'must be formatted correctly.'
                        },length: {
                          maximum: 50, 
                          message: 'must not be more than 50 characters.',
                        }
    validates :zipcode, presence: true,
                        format: {
                          with: /^[0-9 -]+$/,
                          message: 'must be formatted correctly.'
                        },length: {
                          maximum: 9, 
                          message: 'must not be more than 9 characters.',
                        }
    validates :state, allow_blank: true, 
                        format: {
                          with: /^[a-zA-Z ]+$/,
                          message: 'must be formatted correctly.'
                        },length: {
                          maximum: 50, 
                          message: 'must not be more than 50 characters.',
                        }
    validates :country, allow_blank: true,
                        format: {
                          with: /^[a-zA-Z ]+$/,
                          message: 'must be formatted correctly.'
                        },length: {
                          maximum: 50, 
                          message: 'must not be more than 50 characters.',
                        }
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true                           

	  acts_as_votable
    acts_as_followable
    acts_as_ordered_taggable
  	acts_as_ordered_taggable_on :markers
    has_many :comments, as: :commentable
    has_many :uploads, as: :uploadable
    has_many :updates, as: :updateable

    before_validation :clean_up_markers

  	has_attached_file :avatar, styles: {activity: "300>", thumb: "30x30#", av: "165x165#", list: "230x230#"},
  								:default_url => '/assets/Events Default.png'
  	has_attached_file :banner, styles: { large: "1400x200<", preview: "600x200>" },
  								:default_url => '/assets/Events Banner Default.png'

    validates_attachment_size :avatar, :less_than_or_equal_to=>10.megabyte
  	validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	validates_attachment_size :banner, :less_than_or_equal_to=>10.megabyte
  	validates_attachment_content_type :banner, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  	auto_html_for :video do
	    html_escape
	    image
	    youtube(:width => 660, :height => 400, :autoplay => false)
	    vimeo(:width => 660, :height => 400, :autoplay => false)
	    link :target => "_blank", :rel => "nofollow"
	    simple_format
	end

  searchable :auto_index => true, :auto_remove => true do
    text :name, :boost => 5
    text :marker_list, :boost => 2
    text :city, :location
    string :marker_list, :multiple => true, :stored => true
    string :event_month
    date :start_date
    date :end_date
  end

  def event_month
    start_date.strftime("%B")
  end

	private

	  def each_marker
	    marker_list.each do |marker|
	      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
	      errors.add(:marker, "Too long (Maximum is 15 characters)") if marker.length > 15
	    end
	  end

	  def clean_up_markers
	    # Make lowercase 
	    self.marker_list.map!(&:downcase) 
	  end

end
