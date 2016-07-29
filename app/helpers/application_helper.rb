module ApplicationHelper

	require 'embedly'
	require 'json'

	def bootstrap_paperclip_media(form, paperclip_object)
		if form.object.send("#{paperclip_object}?")
			content_tag(:div, class: '') do 
					image_tag form.object.send(paperclip_object).send(:url, :medium)
			end 
		end 
	end

	def bootstrap_paperclip_uploads(form, paperclip_object)
		if form.object.send("#{paperclip_object}?")
			content_tag(:div, class: '') do 
					image_tag form.object.send(paperclip_object).send(:url, :upload)
			end 
		end 
	end 

	def status_document_link(status)
		if status.document && status.document.attachment?
			link_to(image_tag(status.document.attachment.url(:activity)), status.document.attachment.url(:large), class: 'fancybox') 
		end 
	end 

	def avatar_profile_link(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:thumb) : "Default-Av-Thumb.png"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

	def avatar_profile(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:av) : "Default-Av.png"
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

	def truncate_tag(tag)
	  tag.size > 17 ? tag[0,14] + "..." : tag
	end

	def display(url)
	  embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])
	  obj = embedly_api.oembed(:url => url)
	  (obj.first.html).to_s.html_safe
	end

	def media_display(url)
	  embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])
	  obj = embedly_api.oembed(:url => url, width: "188px", height: "188px")
	  (obj.first.html).to_s.html_safe
	end

	def list_display(url)
	  embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])
	  obj = embedly_api.oembed(:url => url, width: "300px", height: "300px")
	  (obj.first.html).to_s.html_safe
	end

	def upload_display(url)
	  embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])
	  obj = embedly_api.oembed(:url => url, width: "188px", height: "188px")
	  (obj.first.html).to_s.html_safe
	end

	def cp(path)
	  "current" if request.path.start_with?(path)
	end

	def cp_p_f(path)
	  "current" if request.path.include?(path)
	end

	def cp_p_s(path)
	  "current" if request.path.include?(path)
	end

	def cp_p_m(path)
	  "current" if request.path.include?(path)
	end

	def cp_p_mk(path)
	  "current" if request.path.include?(path)
	end

	def cp_p_e(path)
	  "current" if request.path.include?(path)
	end

	def cp_p_p(path)
	  "current" if request.path.include?(path)
	end

end
