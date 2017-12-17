class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages.order(id: :asc)
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages.order(id: :asc)
    end

    # update "read" status.
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end

    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path, notice: "メッセージを投稿しました。"
    else
      redirect_to conversation_messages_path, flash: { error: @message.errors.full_messages }
    end

  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
