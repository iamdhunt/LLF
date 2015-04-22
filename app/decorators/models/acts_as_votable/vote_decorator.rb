ActsAsVotable::Vote.class_eval do

	after_create :create_notification, unless: Proc.new { |vote| vote.voter.id == vote.votable.member.id }

	def create_notification
		subject = "#{voter.user_name}"
		body = "<b>favorited</b> your <b>#{votable_type.downcase}</b>"
		votable.member.notify(subject, body, self)
	end

end 