class CommentsController < ApplicationController
  authorize_resource
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_parameters)
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
    authorize! :destroy, @comment
    @comment.destroy
    flash[:notice] = 'Comment successfully deleted.'
    redirect_to user_post_path(@post.author_id, @post.id)
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
