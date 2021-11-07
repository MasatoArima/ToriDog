class Customer::ApplicationsController < ApplicationController

  def create
    @application = current_customer.applications.new(application_params)
    if @application.save
      redirect_to request.referer, notice: '登録しました'
    else
      flash[:alert] = '登録に失敗しました'
      render :new
    end
  end
  def update
    @application = Application.find(params[:id])
    @application.update(application_params)
    redirect_to request.referer
  end



  private
  def application_params
    params.require(:application).permit(:comment,:request_id)
  end
end
