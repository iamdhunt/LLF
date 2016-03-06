class Upload < ActiveRecord::Base
	attr_accessible :asset, :caption, :cover, :remove_cover

	attr_accessor :remove_cover

   	belongs_to :member
	belongs_to :uploadable, polymorphic: true

	has_many :mentions, as: :mentioner, dependent: :destroy

	has_attached_file :asset, styles: lambda { |a| a.instance.asset_content_type =~ %r(image) ? {large: "700x700>", medium: "300x200>", list: "188", activity: "300>", small: "260x180>", thumb: "60x60#", thumb2: "30x30#", av: "200x200#"}  : {} }
	has_attached_file :cover, styles: { media: "188x188#" }

	after_commit :create_notification, on: :create
	after_save :save_mentions, unless: Proc.new { |upload| upload.caption.blank? }

	validates_attachment_presence :asset, message: 'image/audio can\'t be blank.'                   
	validates_attachment_size :asset, :less_than=>15.megabyte, message: 'image/audio must be less than or equal to 15mb.'
	validates_attachment_content_type :asset, 
										:content_type=>['image/jpeg', 'image/jpg', 'image/png', 
											'audio/mp3', 'audio/mpeg', 'audio/mpeg3', 'audio/mpg',
											'audio/x-mp3', 'audio/x-mpeg', 'audio/x-mpeg3', 'audio/x-mpegaudio', 'audio/x-mpg'],
										message: 'must be a .jpeg, .jpg, .png, or .mp3 file type.'

	validates_attachment_size :cover, :less_than_or_equal_to=>15.megabyte, message: 'must be less than or equal to 15mb.'
  	validates_attachment_content_type :cover, :content_type=>['image/jpeg', 'image/jpg', 'image/png'],
  												message: 'must be a .jpeg, .jpg, or .png file type.'

  	auto_strip_attributes :caption

	def create_notification
		subject = "#{member.user_name}"
		body = "<b>uploaded</b> new media in <b>#{uploadable.name}</b>"
		uploadable.followers.each{ |follower| follower.notify(subject, body, self) }
	end

	USERNAME_REGEX = /@\w+/i

	before_save :perform_cover_removal

	private

		def perform_cover_removal
	      if remove_cover == '1' && !cover.dirty?
	        self.cover = nil
	      end
	    end	

	    def save_mentions
	      return unless mention?

	      people_mentioned.each do |member|
	        Mention.create!(:comment_id => self.id, :mentioner_id => self.id, :mentioner_type => 'Upload', :mentionable_id => member.id, :mentionable_type => 'Member')
	      end
	    end

	    def mention?
	      self.caption.match( USERNAME_REGEX )
	    end

	    def people_mentioned
	      members = []
	      self.caption.clone.gsub!( USERNAME_REGEX ).each do |user_name|
	        member = Member.find_by_user_name(user_name[1..-1])
	        members << member if member
	      end
	      members.uniq
	    end					
end
