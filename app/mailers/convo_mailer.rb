class ConvoMailer < ActionMailer::Base
  default from: "THE COLLECTIVV by L&#215;L&#215;F <noreply@livinglifefearless.co>"
  #Sends and email for indicating a new message or a reply to a receiver.
  #It calls new_message_email if notifing a new message and reply_message_email
  #when indicating a reply to an already created conversation.
  def send_email(message, receiver)
    if message.conversation.messages.size > 1
      return nil
    else
      new_convo_email(message,receiver)
    end
  end

  #Sends an email for indicating a new message for the receiver
  def new_convo_email(message,receiver)
    @message  = message
    @receiver = receiver
    mail :to => receiver.send(Mailboxer.email_method, message),
         :subject => "#{message.sender.full_name} (#{message.sender.user_name}) wants to talk",
         :template_name => 'new_convo_email'
  end

  #Sends and email for indicating a reply in an already created conversation
  def reply_message_email(message,receiver)
    @message  = message
    @receiver = receiver
    mail :to => receiver.send(Mailboxer.email_method, message),
         :subject => "You have a new conversation"
  end
end
