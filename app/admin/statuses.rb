ActiveAdmin.register Status do

	filter :id
	filter :member
	filter :created_at

	index do
		selectable_column
		column :id
		column :content
		column :created_at
		default_actions
	end
  
end
