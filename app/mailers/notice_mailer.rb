class NoticeMailer < ApplicationMailer
  def sendmail_blog(blog)
    @blog = blog
    #@url = "localhost:3000"
    mail to: "hito.0525@gmail.com", subject: '[Archive]ブログが投稿されました'
  end

  def sendmail_contact(contact)
    @contact = contact

    mail to: @contact.email,
        subject: '【Achieve】お問い合わせを承りました！'
  end
end




