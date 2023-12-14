class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_parameters)
    @post.author_id = @user.id

    if @post.save
      flash[:notice] = 'The post is successfully submitted'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Can not save the post'
      render :new
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post
      @post.likes.destroy_all
      if @post.destroy
        flash[:notice] = 'Post successfully deleted.'
      else
        flash[:alert] = 'Failed to delete the post.'
      end
    else
      flash[:alert] = 'Post not found.'
    end

    redirect_to user_posts_path(id: current_user.id)
  end

  private

  def post_parameters
    params.require(:post).permit(:title, :text)
  end
end
