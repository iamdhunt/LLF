module MentionsHelper

	def statuses_with_mentions(status)
	  	status.content.gsub(/@\w+/).each do |user_name|
		    member = Member.find_by_user_name(user_name[1..-1])
		    if member
		      link_to user_name, profile_path(member.user_name), class: 'mem_mnts'
		    else
		      user_name
		    end
		end 
	end

	def comments_with_mentions(comment)
	  	comment.content.gsub(/@\w+/).each do |user_name|
		    member = Member.find_by_user_name(user_name[1..-1])
		    if member
		      link_to user_name, profile_path(member.user_name), class: 'mem_mnts'
		    else
		      user_name
		    end
		end 
	end

	def media_with_mentions(medium)
	  	medium.caption.gsub(/@\w+/).each do |user_name|
		    member = Member.find_by_user_name(user_name[1..-1])
		    if member
		      link_to user_name, profile_path(member.user_name), class: 'mem_mnts'
		    else
		      user_name
		    end
		end 
	end

	def uploads_with_mentions(upload)
	  	upload.caption.gsub(/@\w+/).each do |user_name|
		    member = Member.find_by_user_name(user_name[1..-1])
		    if member
		      link_to user_name, profile_path(member.user_name), class: 'mem_mnts'
		    else
		      user_name
		    end
		end 
	end

	def updates_with_mentions(update)
	  	update.content.gsub(/@\w+/).each do |user_name|
		    member = Member.find_by_user_name(user_name[1..-1])
		    if member
		      link_to user_name, profile_path(member.user_name), class: 'mem_mnts'
		    else
		      user_name
		    end
		end 
	end

	def projects_with_mentions(project)
	  	project.about.gsub(/@\w+/).each do |user_name|
		    member = Member.find_by_user_name(user_name[1..-1])
		    if member
		      link_to user_name, profile_path(member.user_name), class: 'mem_mnts'
		    else
		      user_name
		    end
		end 
	end

	def events_with_mentions(event)
	  	event.details.gsub(/@\w+/).each do |user_name|
		    member = Member.find_by_user_name(user_name[1..-1])
		    if member
		      link_to user_name, profile_path(member.user_name), class: 'mem_mnts'
		    else
		      user_name
		    end
		end 
	end

	def listings_with_mentions(listing)
	  	listing.description.gsub(/@\w+/).each do |user_name|
		    member = Member.find_by_user_name(user_name[1..-1])
		    if member
		      link_to user_name, profile_path(member.user_name), class: 'mem_mnts'
		    else
		      user_name
		    end
		end 
	end

end
