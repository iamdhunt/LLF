module FollowsHelper

	def follow_profile_link(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:follow) : "Default-Av-Follow.png"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

end
