class Customer::DogsController < ApplicationController
  def index
    @dogs = Dog.where(customer_id: current_customer.id)
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def new
    @dog =Dog.new
  end

  def create
    @dog = current_customer.dogs.new(dog_params)
    if @dog.save
      redirect_to dog_path(@dog), notice: '登録しました'
    else
      flash[:alert] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    @dog.update(dog_params)
    redirect_to dog_path(@dog.id)
  end

  def destroy
    dog = Dog.find(params[:id])
    dog.destroy
    redirect_to dogs_path
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :name_kana, :breed, :sex, :size, :is_inoculate, :inoculation_date, :birthday, :medical_history, :introduction)
  end
end
