ActiveAdmin.register Event do

	filter :id
	filter :member
	filter :name
	filter :category
	filter :start_date
	filter :end_date
	filter :start_time
	filter :end_time
	filter :location
	filter :city
	filter :state 
	filter :country
	filter :created_at

	index do
		selectable_column
		column :id
		column :name
		column :category
		column :start_date
		column :end_date
		column :start_time
		column :end_time
		column :created_at
		default_actions
	end
  
end
