module CommentsHelper

	def comment_avatar_link(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:av) : "Default-User.jpg"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

	def comment_avatar_link_2(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:av) : "Default-User.jpg"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

end
