module ApplicationHelper

	def status_document_link(status)
		if status.document && status.document.attachment?
			link_to("Attachment", status.document.attachment.url, class: "label label-info") 
		end 
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
