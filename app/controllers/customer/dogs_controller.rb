class Customer::DogsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @dogs = current_customer.dogs.where(is_deleted: false)
  end

  def show
    @dog = Dog.find(params[:id])
    @blob = @dog.trimming_images.first
    if params[:blob].present?
      @blob = @dog.trimming_images.find_by(id: params[:blob])
    end
  end

  def new
    @dog = Dog.new
  end

  def create
    @dog = current_customer.dogs.new(dog_params)
    if @dog.save
      redirect_to dog_path(@dog)
    else
      flash[:alert] = @dog.errors.full_messages
      redirect_to new_dog_path
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    dog = Dog.find(params[:id])
    if params[:dog][:image_ids].nil?
      dog.update(dog_params)
    else
      params[:dog][:image_ids].each do |image_id|
        image = dog.trimming_images.find(image_id)
        image.purge
      end
    end
    redirect_to dog_path(dog.id)
  end

  def destroy
    dog = Dog.find(params[:id])
    if dog.update(is_deleted: true)
      redirect_to dogs_path
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :name_kana, :breed, :sex, :size, :is_inoculate, :inoculation_date, :birthday, :medical_history, :introduction, :dog_image, trimming_images: [])
  end
end
