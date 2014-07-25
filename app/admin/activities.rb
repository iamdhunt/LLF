ActiveAdmin.register Activity do

	filter :id
	filter :member
	filter :targetable_type
	filter :created_at

	index do
		selectable_column
		column :id
		column :targetable_type
		column :created_at
		default_actions
	end
  
end
