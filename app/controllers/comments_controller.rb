class CommentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_current_user, only: [:create]
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = @user.id
    @comment.post_id = @post.id

    if @comment.save
      flash[:notice] = 'The post is successfully submitted'
      redirect_to user_post_path(@post.author_id, @post)
    else
      flash[:alert] = 'Can not save the comment'
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    flash[:notice] = 'Comment successfully deleted.'
    redirect_to user_post_path(@post.author_id, @post.id)
  end

  private

  def set_current_user
    @user = current_user
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
