module EventsHelper

	def avatar_event_link(event, image_options={}, html_options={})
	    avatar_url = event.avatar? ? event.avatar.url(:list) : "Events-List-Default.png"
	    link_to(image_tag(avatar_url, image_options), event_path(event), html_options)
	end

	def activity_event_link(event, image_options={}, html_options={})
	    avatar_url = event.avatar? ? event.avatar.url(:activity) : "Events-List-Default-2.png"
	    link_to(image_tag(avatar_url, image_options), event_path(event), html_options)
	end
	
end
