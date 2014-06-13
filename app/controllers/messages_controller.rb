class MessagesController < ApplicationController
 
  # GET /message/new
  def new
    @member = Member.find(params[:member])
    @message = current_member.messages.new
  end
 
   # POST /message/create
  def create
    @recipient = Member.find(params[:member])
    current_member.send_message(@recipient, params[:body], params[:subject])
    redirect_to :conversations
  end

end