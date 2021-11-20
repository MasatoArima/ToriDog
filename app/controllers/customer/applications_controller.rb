class Customer::ApplicationsController < ApplicationController
  def create
    @application = current_customer.applications.new(application_params)
    if @application.save
      redirect_to customers_mypage_path, notice: '登録しました'
    else
      flash[:alert] = '登録に失敗しました'
      redirect_to request.referer
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update(application_params)
    redirect_to customers_mypage_path, notice: '更新しました'
  end

  def destroy
    application = Application.find(params[:id])
    application.destroy
    redirect_to customers_mypage_path, notice: '応募を取りやめました'
  end

  private
  def application_params
    params.require(:application).permit(:comment, :request_id, :first_preferred_date, :last_preferred_date)
  end
end
