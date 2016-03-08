class Update < ActiveRecord::Base

	attr_accessible :title, :content

	attr_accessor :mention

  	belongs_to :member
	belongs_to :updateable, polymorphic: true

	has_many :mentions, as: :mentioner, dependent: :destroy

	after_commit :create_notification, on: :create

	after_save :save_mentions

	validates :title, presence: { message: 'can\'t be blank.'}

  	validates :content, presence: { message: 'can\'t be blank.'}

  	auto_strip_attributes :content
	auto_strip_attributes :title, :squish => true

	USERNAME_REGEX = /@\w+/i

	def create_notification
		subject = "#{member.user_name}"
		body = "posted a new <b>update</b> <i>\"#{title}\"</i> in <b>#{updateable.name}</b> <p><i>#{content}</i></p>"
		updateable.followers.each{ |follower| follower.notify(subject, body, self) }
	end

	private

		def save_mentions
	      return unless mention?

	      people_mentioned.each do |member|
	        Mention.create!(:update_id => self.id, :mentioner_id => self.id, :mentioner_type => 'Update', :mentionable_id => member.id, :mentionable_type => 'Member')
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
