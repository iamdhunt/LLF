ActiveAdmin.register Medium do

	filter :id
	filter :member
	filter :asset_content_type
	filter :asset_file_size
	filter :created_at

	index do
		selectable_column
		column :id
		column :asset_file_name
		column :asset_content_type
		column :asset_file_size
		column :created_at
		default_actions
	end
  
end
