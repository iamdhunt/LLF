module ListingsHelper

	def list_av(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:thumb2) : "Default Av Thumb 3.png"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

end
