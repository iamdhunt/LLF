module ListingsHelper

	def list_av(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:thumb2) : "Default-User.jpg"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

	def list_profile_link(member, image_options={}, html_options={})
	    avatar_url = member.avatar? ? member.avatar.url(:listing) : "Default-User.jpg"
	    link_to(image_tag(avatar_url, image_options), profile_path(member.user_name), html_options)
	end

	def activity_listing_link(listing, image_options={}, html_options={})
	    feature_url = listing.feature? ? listing.feature.url(:index) : "Default-Listing.jpg"
	    link_to(image_tag(feature_url, image_options), listing_path(listing), html_options)
	end

end
