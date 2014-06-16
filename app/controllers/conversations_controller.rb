class ConversationsController < ApplicationController
    before_filter :authenticate_member!
    helper_method :mailbox, :conversation

    def index
    	@messages_count = current_member.mailbox.inbox({:read => false}).count
   	 	@conversations ||= current_member.mailbox.inbox.order('created_at desc').page(params[:page]).per_page(15)
   	 	@sent ||= current_member.mailbox.sentbox.order('created_at desc').page(params[:page]).per_page(15)
   	 	@trash ||= current_member.mailbox.trash.order('created_at desc').page(params[:page]).per_page(15)
    end

    def show
	    @receipts = conversation.receipts_for(current_member).order('created_at desc').page(params[:page]).per_page(15)

	    render :action => :show
	    @receipts.mark_as_read 
	end

    def create
	    recipient_emails = conversation_params(:recipients).split(',')
	    recipients = Member.where(user_name: recipient_emails).all

	    conversation = current_member.
	      send_message(recipients, *conversation_params(:body, :subject)).conversation

	    redirect_to :back
	end

    def reply
	  current_member.reply_to_conversation(conversation, *message_params(:body, :subject))
	  redirect_to conversation_path
	end

	def trash  
		conversation.move_to_trash(current_member)  
		redirect_to :conversations 
	end

	def untrash  
		conversation.untrash(current_member)  
		redirect_to :back 
	end

	def empty_trash   
		current_member.mailbox.trash.each do |conversation|    
			conversation.receipts_for(current_member).update_all(:deleted => true)
  		end
 		redirect_to :conversations
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