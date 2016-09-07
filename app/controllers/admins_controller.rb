class AdminsController < ApplicationController
  before_action :authenticate_user!, :set_admin

  def user_index
    @users = User.all.paginate(:page => params[:page], :per_page => 30)
  end

  def user_posts
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 10)
  end

  def user_comments
    @user = User.find(params[:id])
    @comments = @user.comments.paginate(:page => params[:page], :per_page => 10)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def chenge
    @user = User.find(params[:id])
    unless current_user == @user
      if @user.user?
        @user.admin!
      else
        @user.user!
      end
      redirect_to admins_set_user_path(@user), :notice => "Role was changed to #{@user.role}"
    else
      redirect_to admins_set_user_path(@user), :alert => "You can't change your role!outes"
    end
  end


  private

  def set_admin
    unless current_user.admin?
      # render :text => 'Not Found', :status => '404'
      # render :text => 'Not Found', :status => :not_found
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
end
