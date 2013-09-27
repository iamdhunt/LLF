module ApplicationHelper

	def status_document_link(status)
		if status.document && status.document.attachment?
			link_to("Attachment", status.document.attachment.url, class: "label label-info") 
		end 
	end 

	def avatar_profile_link(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:thumb) : "Default Av Thumb.png"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

	def avatar_profile(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:av) : "Default Av.png"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

	def flash_class (type)
		case type
		when :alert
			"alert-error"
		when :notice
			"alert-success"
		else 
			"alert-info"
		end
	end

end
