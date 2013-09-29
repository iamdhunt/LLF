module MediaHelper

	def can_edit_medium?(medium)
		signed_in? && current_member == medium.member
	end 

end
