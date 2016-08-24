class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #
   def sendmail_blog(blog)
    @blog = blog
    @url = "localhost:3000"

    mail( to: "hito.0525@gmail.com", subject: '[Archive]ブログが投稿されました')
  end
end
