class NotificationsController < ApplicationController
    before_filter :authenticate_member!

    def index
    	@notifications_count = current_member.mailbox.notifications({:read => false}).count
   	 	@notifications = current_member.mailbox.notifications.order('created_at desc').limit(150).page(params[:page]).per_page(50)
      
      respond_to do |format|
        format.html
        format.js
      end
    end

    def update_all
      @notifications = current_member.mailbox.notifications.order('created_at desc').limit(150).page(params[:page]).per_page(50)
	    @unread = current_member.mailbox.notifications({:read => false}).all
	    current_member.mark_as_read @unread

        respond_to do |format|
          format.html { redirect_to notifications_path }
          format.js
        end
	end

end