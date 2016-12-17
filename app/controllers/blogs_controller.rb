class BlogsController < ApplicationController
before_action :authenticate_user!
before_action :current_user, only: [:edit,:update]
before_action :set_blog, only: [:show, :edit, :update, :destroy, :liking_users]

  def index
    @blogs = Blog.all
    #binding.pry
    @blogs = Blog.order(:created_at).reverse_order

  end

  def show
    @comment = @blog.comments.build
    @comments = @blog.comments

  end


  def new
    if params[:back]
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
  else

    #新規作成ボタンからうつれるように！！
      @blog = Blog.new
      @blog.user_id = current_user.id

    end
  end

  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    if @blog.save
       # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示してこのアクションは終了！！。
    #Blog.create(blogs_params)
    redirect_to blogs_path, notice: "ブログを作成しました！"
    NoticeMailer.sendmail_blog(@blog).deliver
  else
    render action: 'new'
    #入力フォームへ再び止める.

  end
  end

  def edit
  end

  def update
    if @blog.update(blogs_params)
    redirect_to blogs_path, notice: "ブログを更新しました！"
  else
    render action:edit
  end
end

  def destroy
    @blog.destroy
    redirect_to blogs_path,notice: "ブログを削除しました！"
  end

  def confirm
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end

  def liking_user
    @users = @blog.liking_users
  end


private

  def blogs_params
    params.require(:blog).permit(:title,:content)
  end
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def correct
    blog = Blog.find(params[:id])
    if !current_user?(blog.user)
      redirect_to root_path, alert: '許可されてないページです'
    end
  end

end


