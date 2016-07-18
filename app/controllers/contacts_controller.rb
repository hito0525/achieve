class ContactsController < ApplicationController
  def new
    if params[:back]
    @contact = Contact.new(contacts_params)
  else
    @contact = Contact.new
  end
end

  def create
    @contact = Contact.new(contacts_params)
    if @contact.save
    #Contact.create(contacts_params)
    redirect_to new_contact_path,notice: "お問い合わせを受け付けました！"
  else
    render action: "new"
  end
end

  def confirm
    @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  end



private
def contacts_params
  params.require(:contact).permit(:name, :email, :content)
end


end


