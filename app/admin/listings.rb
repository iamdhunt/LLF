ActiveAdmin.register Listing do

	filter :id
	filter :member
	filter :price
	filter :title
	filter :category
	filter :created_at

	index do
		selectable_column
		column :id
		column :title
		column :link
		column :category
		column :price
		column :created_at
		default_actions
	end
  
end
