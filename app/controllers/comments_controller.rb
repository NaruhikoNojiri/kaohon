class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment_and_topic, only:[:edit,:destroy,:update]

  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    respond_to do |format|
      if @comment.save
        @comment = @topic.comments.build #jsでformを再描画するためのリセット
        format.html {render "topics/show"}
        format.js {render :index}
      else
        @topics = Topic.all
        @comments = @topic.comments
        format.html {render "topics/show"}
        format.js {render :new}
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to topic_path(@topic), notice: "トピックのコメントを編集しました。"
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      @comment.destroy
      # format.html {redirect_to topic_path(@topic), notice: "コメントを削除しました。"}
      format.js {render :index}
    end
  end

  private
  def comment_params
      params.require(:comment).permit(:topic_id,:content)
  end

  def set_comment_and_topic
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
  end
end
