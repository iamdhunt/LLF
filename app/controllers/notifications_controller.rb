class NotificationsController < ApplicationController
    before_filter :authenticate_member!

    def index
    	@notifications_count = current_member.mailbox.notifications({:read => false}).count
   	 	@notifications = current_member.mailbox.notifications.order('created_at desc').page(params[:page]).per_page(20)

      respond_to do |format|
        format.html
        format.js
      end
    end

    def update_all
	    @notifications = current_member.mailbox.notifications.all
	    current_member.mark_as_read @notifications

        respond_to do |format|
          format.html { redirect_to notifications_path }
          format.js
        end
	end

end