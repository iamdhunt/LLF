ActiveAdmin.register Project do

	filter :id
	filter :member
	filter :name
	filter :category
	filter :city
	filter :created_at

	index do
		selectable_column
		column :id
		column :name
		column :category
		column :website
		column :city
		column :created_at
		default_actions
	end
  
end
