ActiveAdmin.register Member do

	filter :id
	filter :user_name
	filter :full_name
	filter :email
	filter :city
	filter :state
	filter :country
	filter :last_sign_in_at
	filter :created_at

	index do
		selectable_column
		column :id
		column :user_name
		column :full_name
		column :email
		column :created_at
		column :last_sign_in_at
		default_actions
	end
  
end
