module ApplicationHelper

	def bootstrap_paperclip_media(form, paperclip_object)
		if form.object.send("#{paperclip_object}?")
			content_tag(:div, class: '') do 
					image_tag form.object.send(paperclip_object).send(:url, :medium)
			end 
		end 
	end 

	def status_document_link(status)
		if status.document && status.document.attachment?
			link_to(image_tag(status.document.attachment.url(:activity)), status.document.attachment.url) 
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

	def title(page_title)
		content_for(:title) { page_title }
	end 

	def flash_class (type)
		case type
		when :alert
			"alert-error"
		when :notice
			"alert-info"
		else 
			"alert-success"
		end
	end

end
