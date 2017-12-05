class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only:[:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to root_path, notice: "トピックを投稿しました！"
    else
      @topics = Topic.all
      render :index
    end
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
  end

  def edit
  end

  def update
    if @topic.update(topics_params)
      redirect_to topics_path, notice: "トピックを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "トピックを削除しました！"
  end

  private
  def topics_params
    params.require(:topic).permit(:title,:content)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
