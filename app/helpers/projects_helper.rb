module ProjectsHelper

	def avatar_project_link(project, image_options={}, html_options={})
	    avatar_url = project.avatar? ? project.avatar.url(:large) : "Default-Project.jpg"
	    link_to(image_tag(avatar_url, image_options), project_path(project), html_options)
	end

	def activity_project_link(project, image_options={}, html_options={})
	    avatar_url = project.avatar? ? project.avatar.url(:activity) : "Default-Project.jpg"
	    link_to(image_tag(avatar_url, image_options), project_path(project), html_options)
	end
	
end
