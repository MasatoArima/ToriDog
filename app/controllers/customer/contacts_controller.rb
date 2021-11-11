class Customer::ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to root_path, notice: '送信しました'
    else
      render :index
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :phone_number ,:subject ,:message)
  end
end
