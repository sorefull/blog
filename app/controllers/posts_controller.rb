class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show, :userindex]
  def index
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 7)
  end

  def userindex
    @user = User.find(params[:id])
    @posts = @user.posts.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), :notice => "Your post was succesfully created."
    else
      redirect_to new_post_path, alert: @post.errors["title"].first
    end
   end

  def edit
    if current_user.admin? || current_user == Post.find(params[:id]).user
      @post = Post.find(params[:id])
    else
      redirect_to posts_path, alert: "Unable for you."
    end
  end

  def update
    if current_user.admin? || current_user == Post.find(params[:id]).user
      if @post = Post.find(params[:id]).update(post_params)
        redirect_to posts_path, :notice => "Your post was succesfully updated."
      else
        redirect_to new_post_path, alert: @post.errors["title"].first
      end
    else
      redirect_to posts_path, alert: "Unable for you."
    end
  end

  def destroy
    if current_user.admin? || current_user == Post.find(params[:id]).user
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path, alert: "Your post was succesfully deleted!"
    else
      redirect_to posts_path, alert: "Unable for you."
    end
  end


  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
