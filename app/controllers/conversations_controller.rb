class ConversationsController < ApplicationController
    before_filter :authenticate_member!
    helper_method :mailbox, :conversation

    def index
    	@messages_count = current_member.mailbox.inbox({:read => false}).count
   	 	@conversations = current_member.mailbox.inbox.order('updated_at desc').page(params[:page]).per_page(15)
   	 	@sent ||= current_member.mailbox.sentbox.order('updated_at desc').page(params[:page]).per_page(15)
   	 	@trash ||= current_member.mailbox.trash.order('updated_at desc').page(params[:page]).per_page(15)

   	 	respond_to do |format|
   	 	  format.html
		  format.js
		end
    end

    def show
	    @receipts = conversation.receipts_for(current_member).order('updated_at desc').page(params[:page]).per_page(20)

	    render :action => :show
	    @receipts.mark_as_read 
	end

    def create
	    recipient_emails = conversation_params(:recipients).split(',').take(14)
	    recipients = Member.where(user_name: recipient_emails).all

	    @conversation = current_member.send_message(recipients, *conversation_params(:body, :subject)).conversation

	    respond_to do |format|
          format.html { redirect_to conversation_path(conversation) }
          format.js
      	end  
	end

    def reply
    	@receipts = conversation.receipts_for(current_member).order('created_at desc').page(params[:page]).per_page(20)
	  	@receipt = current_member.reply_to_conversation(conversation, *message_params(:body, :subject))
	  
	  	respond_to do |format|
          format.html { conversation_path(conversation) }
          format.js 
      	end
	end

	def trash 
		@trash ||= current_member.mailbox.trash.order('updated_at desc').page(params[:page]).per_page(15)
		@sent = current_member.mailbox.sentbox.order('updated_at desc').page(params[:page]).per_page(15) 
		conversation.move_to_trash(current_member)

		respond_to do |format|
          format.html { redirect_to :conversations }
          format.js
      	end   
	end

	def untrash
		@conversations = current_member.mailbox.inbox.order('updated_at desc').page(params[:page]).per_page(15)
   	 	@sent = current_member.mailbox.sentbox.order('updated_at desc').page(params[:page]).per_page(15)
		conversation.untrash(current_member)  
		
		respond_to do |format|
          format.html { redirect_to :back }
          format.js
      	end  
	end

	def empty_trash
		@trash ||= current_member.mailbox.trash.order('updated_at desc').page(params[:page]).per_page(15)
		current_member.mailbox.trash.each do |conversation|    
			conversation.receipts_for(current_member).update_all(:deleted => true)
  		end
 		
 		respond_to do |format|
          format.html { redirect_to :conversations }
          format.js
      	end 
	end

	def polling 
		@conversations = current_member.mailbox.inbox.where('conversation_id > ?', params[:after].to_i).order('updated_at desc')
	end 

	def refresh
		@conversations = current_member.mailbox.inbox.order('updated_at desc').page(params[:page]).per_page(15)

		respond_to do |format|
		  format.js
		end
	end 

	private
 
		def mailbox
		 @mailbox ||= current_member.mailbox
		end
		 
		def conversation
		 @conversation ||= mailbox.conversations.find(params[:id])
		end
		 
		def conversation_params(*keys)
		 fetch_params(:conversation, *keys)
		end
		 
		def message_params(*keys)
		 fetch_params(:message, *keys)
		end
		 
		def fetch_params(key, *subkeys)
		 params[key].instance_eval do
		   case subkeys.size
		   when 0 then self
		   when 1 then self[subkeys.first]
		   else subkeys.map{|k| self[k] }
		   end
		 end
		end

		def check_current_subject_in_conversation
		    if !conversation.is_participant?(current_member)
		      redirect_to conversations_path
		    end
		end

end