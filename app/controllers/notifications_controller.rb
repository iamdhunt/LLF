class NotificationsController < ApplicationController
    before_filter :authenticate_member!

    def index
    	@notifications_count = current_member.mailbox.notifications({:read => false}).count
   	 	@notifications = current_member.mailbox.notifications.order('created_at desc').page(params[:page]).per_page(30)
    end

    def update_all
	    @notifications = current_member.mailbox.notifications.all
	    current_member.mark_as_read @notifications

	    redirect_to notifications_path
	end

end