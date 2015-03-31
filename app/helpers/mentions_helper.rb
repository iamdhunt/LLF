module MentionsHelper

	def statuses_with_mentions(status)
	  	status.content_html.gsub(/@\w+/).each do |user_name|
		    member = Member.find_by_user_name(user_name[1..-1])
		    if member
		      link_to user_name, profile_path(member.user_name)
		    else
		      user_name
		    end
		end 
	end

end
