class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_param)
    if @post.save
      flash[:notice] = 'Post saved.'
      redirect_to @post
    else
      flash[:error] = 'Errors in form.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_param)
      flash[:notice] = 'Post updated.'
      redirect_to @post
    else
      flash[:error] = 'Errors in form.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post destroyed.'
      redirect_to posts_path
    else
      flash[:error] = 'Error delete post.'
      redirect_back fallback_location: :posts_path
    end
  end

  private

  def post_param
    params.require(:post).permit(:title, :body, :summary, :published)
  end
end
