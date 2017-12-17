module MessagesHelper
  def my_message?(message)
    if current_user.id == message.user_id
      "right"
    else
      "left"
    end
  end

  def get_receiver(conversation)
    if conversation.present?
      if conversation.sender_id == current_user.id
        User.find(conversation.recipient_id)
      else
        User.find(conversation.sender_id)
      end
    end
  end
end
