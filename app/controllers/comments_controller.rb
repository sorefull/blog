class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  def create
    @comment = current_user.comments.build(comment_params.merge(post_id: @post.id))
    if @comment.save
      redirect_to post_path(@comment.post), :notice => "Your comment was succesfully created!"
    else
      redirect_to post_path(@comment.post), alert: @comment.errors["title"].first
    end
  end

  def destroy
    if current_user.admin? || current_user == @post.user
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      redirect_to post_path(@post), alert: "Your comment was deleted!"
    else
      redirect_to posts_path, alert: "Unable for you."
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
