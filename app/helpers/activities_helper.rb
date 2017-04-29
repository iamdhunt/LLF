module ActivitiesHelper

	def act_profile_link(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:thumb) : "Default-User.jpg"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

end
