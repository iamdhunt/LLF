class Comment < ActiveRecord::Base
	belongs_to :member
	belongs_to :commentable, polymorphic: true

	has_many :mentions, dependent: :destroy

	attr_accessor :mention
	attr_accessible :content

	validates :content, presence: true,
				length: { minimum: 2, maximum: 280 }

	after_create :send_email, :create_notification, on: :create, unless: Proc.new { |comment| comment.member.id == comment.commentable.member.id }
	after_save :save_mentions

	auto_strip_attributes :content

	def create_notification
		subject = "#{member.user_name}"
		body = "left a <b>comment</b> on your <b>#{comment.commentable_type.downcase}</b> <p><i>#{content}</i></p>"
		commentable.member.notify(subject, body, self)
	end

	def send_email
	    CommentMailer.email_notification(member, commentable, self).deliver
	end

	USERNAME_REGEX = /@\w+/i


	private

	def save_mentions
	    return unless mention?

	    people_mentioned.each do |member|
	    	Mention.create!(:comment_id => self.id, :mentioner_id => self.id, :mentioner_type => 'Comment', :mentionable_id => member.id, :mentionable_type => 'Member')
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
