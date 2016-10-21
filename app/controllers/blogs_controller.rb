class BlogsController < ApplicationController
before_action :authenticate_user!
before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
    #binding.pry
    @blogs = Blog.order(:created_at).reverse_order

  end

   # showアククションを定義します。入力フォームと一覧を表示するためインスタンスを2つ生成します。
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

    # edit, update, destroyで共通コード
    #set_blogで共通化
    #@blog = Blog.find(params[:id])
  end

  def update
    # edit, update, destroyで共通コード
    #set_blogで共通化
    #@blog = Blog.find(params[:id])
    if @blog.update(blogs_params)
    redirect_to blogs_path, notice: "ブログを更新しました！"
  else
    render action: 'edit'
  end
end

  def destroy
    # edit, update, destroyで共通コード
    #set_blogで共通化
    #@blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path,notice: "ブログを削除しました！"
  end

  def confirm
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end
end



private
def blogs_params
  params.require(:blog).permit(:title,:content)
end
def set_blog
  @blog = Blog.find(params[:id])

end


