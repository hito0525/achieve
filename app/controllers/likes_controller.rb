class LikesController < ApplicationController
  def like
    blog = Blog.find(params[:blog_id])
    like = current_user.likes.build(blog_id: blog.id)
    like.save
    redirect_to blog
  end

  def unlike
    blog = Blog.find(params[:blog_id])
    like = current_user.likes.find_by(blog_id: blog.id )
    like.destroy
    redirect_to blog
  end

end





# @like = Like.create(user_id: current_user.id, blog_id: params[:blog_id])
    # @likes = Like.where(blog_id: params[:blog_id])
    # @blogs = Blog.all
    # @blog = Blog.find(params[:blog_id])
    # like = current_user.likes.build(blog_id: @blog.id)
    # like.save
    # #redirect_to Blog


    #  @blog = Blog.find(params[:blog_id])
    # like = current_user.likes.find_by(blog_id: @blog.id)
    # like.destroy

    # like = Like.find_by(user_id: current_user.id, blog_id: params[:blog_id])
    # like.destroy
    # @likes = Like.where(blog_id: params[:blog_id])
    # @blog = Blog.all
