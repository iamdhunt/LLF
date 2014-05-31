module BrandsHelper

	def logo_brand_link(brand, image_options={}, html_options={})
	    logo_url = brand.logo? ? brand.logo.url(:list) : "Products List Default.png"
	    link_to(image_tag(logo_url, image_options), brand_path(brand), html_options)
	end

	def activity_brand_link(brand, image_options={}, html_options={})
	    logo_url = brand.logo? ? brand.logo.url(:activity) : "Products List Default 2.png"
	    link_to(image_tag(logo_url, image_options), brand_path(brand), html_options)
	end

end
